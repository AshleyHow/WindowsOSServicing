Function Get-WindowsServicing {
    <#
        .SYNOPSIS
            Gets Windows OS servicing information to check if OS is currently serviced. Useful for scripting and automation purposes. Supports Windows 10 and Windows Server 2016 onwards.
        .DESCRIPTION
            Gets Windows OS servicing information (OS Name, Version, Service start date, Service end date, Serviced, Lifecycle Policy URL) for Windows client and server versions.
        .PARAMETER Caption
            This parameter is optional. Returns servicing information for specified operating system caption. Supported accepted values:

            Windows Client OS Captions          - Windows 10 Home
                                                - Windows 10 Pro
                                                - Windows 10 Pro for Workstations
                                                - Windows 10 Pro Education
                                                - Windows 10 Business
                                                - Windows 10 Enterprise
                                                - Windows 10 IoT Enterprise
                                                - Windows 10 Education
                                                - Windows 10 Enterprise multi-session

                                                - Windows 10 Enterprise 2015 LTSB
                                                - Windows 10 Enterprise 2016 LTSB
                                                - Windows 10 Enterprise LTSC 2019
                                                - Windows 10 Enterprise LTSC 2021
                                                - Windows 10 Enterprise LTSC
                                                - Windows 10 IoT Enterprise LTSC 2021
                                                - Windows 10 IoT Enterprise LTSC

                                                - Windows 11 Home
                                                - Windows 11 Pro
                                                - Windows 11 Pro for Workstations
                                                - Windows 11 Pro Education
                                                - Windows 11 Business
                                                - Windows 11 Enterprise
                                                - Windows 11 IoT Enterprise
                                                - Windows 11 Education
                                                - Windows 11 Enterprise multi-session

            Windows Server OS Captions          - Windows Server Standard
                                                - Windows Server Datacenter
                                                - Windows Server 2016
                                                - Windows Server 2019
                                                - Windows Server 2022
        .PARAMETER Version
            This parameter is required if the operating system has multiple versions such as Windows 10 or 11. Not required if using the CurrentVersion parameter.
        .PARAMETER CurrentVersion
            This parameter is optional. Returns servicing information for the installed version.
        .EXAMPLE
            Get-WindowsServicing -CurrentVersion
            Show Windows OS servicing information for installed version of the operating system.

            Get-WindowsServicing -Caption "Windows 10 Pro" -Version "22H2"
            Show Windows OS servicing information for Windows 10 Pro Version 22H2.

            Get-WindowsServicing -Caption "Windows Server 2022"
            Show Windows OS servicing information for Windows Server 2022.
    #>

    Param (
        [CmdletBinding()]
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            $validValues = @(
                '*Windows 10 Home*',
                '*Windows 10 Pro*',
                '*Windows 10 Pro for Workstations*',
                '*Windows 10 Pro Education*',
                '*Windows 10 Business*',
                '*Windows 10 Enterprise*',
                '*Windows 10 IoT Enterprise*',
                '*Windows 10 Education*',
                '*Windows 10 Enterprise multi-session*',
                '*Windows 11 Home*',
                '*Windows 11 Pro*',
                '*Windows 11 Pro for Workstations*',
                '*Windows 11 Pro Education*',
                '*Windows 11 Business*',
                '*Windows 11 Enterprise*',
                '*Windows 11 Iot Enterprise*',
                '*Windows 11 Education*',
                '*Windows 11 Enterprise multi-session*',
                '*Windows 10 Enterprise 2015 LTSB*',
                '*Windows 10 Enterprise 2016 LTSB*',
                '*Windows 10 Enterprise LTSC 2019*',
                '*Windows 10 Enterprise LTSC 2021*',
                '*Windows 10 Enterprise LTSC*',
                '*Windows 10 IoT Enterprise LTSC 2021*',
                '*Windows 10 IoT Enterprise LTSC*',
                '*Windows Server 2016*',
                '*Windows Server 2019*',
                '*Windows Server 2022*',
                '*Windows Server Standard*',
                '*Windows Server Datacenter*'
            )

            ForEach ($validValue in $validValues) {
                If ($_ -like $validValue) {
                    Return $true
                }
            }
            return $false
        })]
        [String]$Caption,

        [Parameter(Mandatory = $false)]
        [String]$Version,

        [Parameter(Mandatory = $false)]
        [Switch]$CurrentVersion
    )

    # Get Windows version
    Function Get-Version {
        # Check for Windows 10 1507 as ReleaseId does not exist until 1511
        If ((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name CurrentVersion).CurrentVersion -eq "10240") {
            Return "1507"
        }
        Else {
            $ReleaseID = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ReleaseId).ReleaseId
            If ($ReleaseID -eq '2009') {
                $DisplayVersion = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name DisplayVersion).DisplayVersion
                Return $DisplayVersion
            }
            Else {
                Return $ReleaseID
            }
        }
    }

    # Get Windows name/caption
    Function Get-Caption {
        Try {
            $Caption = (Get-CIMInstance -Classname Win32_OperatingSystem -Erroraction Stop).Caption
        }
        Catch {
            $Caption = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').ProductName
        }
        Return $Caption
        If ([String]::IsNullOrEmpty($Caption)) {
            Throw "Get-OSServicing: Unable to detect Operating System. Error: $($_.Exception.Message)"
        }
    }

    # Get caption for current OS
    If ($CurrentVersion -or $Caption.Length -eq 0) {
        $Caption = Get-Caption
    }

    # Find Windows name/caption and set variables
    If ($Caption -match "Windows 10 Enterprise 2015 LTSB") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2015-ltsb"
        $TargetVersion = "1507"
        $TargetListing = "Windows 10 2015 LTSB"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows 10 Enterprise 2016 LTSB") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2016-ltsb"
        $TargetVersion = "1607"
        $TargetListing = "Windows 10 2016 LTSB"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf (($Caption -match "Windows 10 Enterprise LTSC 2019") -or ($Caption -eq "Windows 10 Enterprise LTSC" -and $(Get-Version) -eq "1809")) {
        $FullCaption = "Windows 10 Enterprise LTSC 2019"
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2019"
        $TargetVersion = "1809"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf (($Caption -match "Windows 10 Enterprise LTSC 2021") -or ($Caption -eq "Windows 10 Enterprise LTSC" -and $(Get-Version) -eq "21H2")) {
        $FullCaption = "Windows 10 Enterprise LTSC 2021"
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2021"
        $TargetVersion = "21H2"
        $SecondTableNo = 0
        $EndDateColNo = 2
    }
    ElseIf (($Caption -match "Windows 10 IoT Enterprise LTSC 2021") -or ($Caption -eq "Windows 10 IoT Enterprise LTSC" -and $(Get-Version) -eq "21H2")) {
        $FullCaption = "Windows 10 IoT Enterprise LTSC 2021"
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-iot-enterprise-ltsc-2021"
        $TargetVersion = "21H2"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf (($Caption -match "Windows 10 Home") -or ($Caption -match "Windows 10 Pro") -or ($Caption -match "Windows 10 Business")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    ElseIf (($Caption -match "Windows 10 Enterprise") -or ($Caption -match "Windows 10 Education")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    ElseIf ($Caption -match "Windows 10 IoT Enterprise") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-iot-enterprise"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    ElseIf (($Caption -match "Windows 11 Home") -or ($Caption -match "Windows 11 Pro") -or ($Caption -match "Windows 11 Business")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    ElseIf (($Caption -match "Windows 11 Enterprise") -or ($Caption -match "Windows 11 Education")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    ElseIf ($Caption -match "Windows 11 IoT Enterprise") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-iot-enterprise"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    ElseIf ($Caption -match "Windows Server 2016") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2016"
        $TargetVersion = "1607"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows Server 2019") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2019"
        $TargetVersion = "1809"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows Server 2022") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2022"
        $TargetVersion = "21H2"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf (($Caption -match "Windows Server Standard") -or ($Caption -match "Windows Server Datacenter")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ($(Get-Caption) -notmatch $Caption)) {
            Throw "Get-OSServicing: CurrentVersion parameter is only supported when run from matching operating system"
        }
        Else {
            Throw "Get-OSServicing: Version parameter is required for this operating system"
        }
        $SecondTableNo = 1
        $EndDateColNo = 2
    }
    Else {
        Throw "Get-OSServicing: Unsupported Operating System"
    }

    # Disable progress bar to speed up Invoke-WebRequest calls
    $ProgressPreference = 'SilentlyContinue'

    # Obtain data from webpage
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Try {
        $Webpage = Invoke-WebRequest -Uri $LifecycleURL -UseBasicParsing -ErrorAction Stop
    }
    Catch {
        If ($_.Exception.Message -like '*Access*Denied*You*') {
            Throw "Get-OSServicing: Unable to obtain servicing information. Akamai CDN denial-of-service protection active. Error: $($_.Exception.Message)"
        }
        Else {
            Throw "Get-OSServicing: Unable to obtain servicing information. Please check your internet connectivity. Error: $($_.Exception.Message)"
        }
    }
    $content = $Webpage.Content

    # Create a new HtmlDocument object
    $doc = New-Object HtmlAgilityPack.HtmlDocument

    # Load the HTML content into the HtmlDocument
    $doc.LoadHtml($content)

    # Find all tables on the page
    $tables = $doc.DocumentNode.SelectNodes("//table[@class='table']")

    # Select the second table - variable defines if there is a single table or two tables
    $secondTable = $tables[$SecondTableNo]

    # Find the table rows containing version information
    $rows = $secondTable.SelectNodes(".//tr")

    # Iterate through rows to find the target version
    ForEach ($row in $rows) {
        $cols = $row.SelectNodes(".//td")
        If ($cols.Count -ge 3) {
            $WebpageListing = $cols[0].InnerText.Trim()
                If (($TargetVersion -like "*$WebpageListing*") -or ` # Version match to WebpageListing
                    ($WebpageListing -like "*$TargetVersion*") -or ` # WebpageListing match to version
                    ($TargetListing -like "*$WebpageListing*") -or ` # TargetListing match to WebpageListing
                    ($Caption -like "*$WebpageListing*") -or ` # Caption match to WebpageListing
                    ($FullCaption -like "*$WebpageListing*")) # FullCaption match to WebpageListing (later LTSC releases)
                                                                                                                          {

                    # Servicing Status
                    $startDate = $cols[1].InnerText.Trim()
                    $endDate = $cols[$EndDateColNo].InnerText.Trim()

                    If ($endDate -eq "In Support") {
                        $Serviced = "True"
                    }
                    ElseIf ($(Get-Date) -ge $endDate) {
                        $Serviced = "False"
                    }
                    Else {
                        $Serviced = "True"
                    }

                    # Service End Date
                    If ($endDate -eq "In Support") {
                        $ServiceEndDate = $endDate
                    }
                    Else {
                        $ServiceEndDate = $(([DateTime]::Parse($endDate)).ToString("yyyy-MM-dd"))
                    }

                    # Create servicing data object
                    $ServiceData = [PsCustomObject]@{
                        'Name' = $Caption
                        'Version' = $TargetVersion
                        'Service start date' = $(([DateTime]::Parse($startDate)).ToString("yyyy-MM-dd"))
                        'Service end date' = $ServiceEndDate
                        'Serviced' = $Serviced
                        'Lifecycle Policy URL' = $LifecycleURL
                    }
                    Break
                }
        }
    }
    $ServiceData
}

# SIG # Begin signature block
# MIImbAYJKoZIhvcNAQcCoIImXTCCJlkCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUvGDs+jc97vD7gYehsmAnFp4r
# ul6ggiAnMIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkqhkiG9w0B
# AQwFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVk
# IElEIFJvb3QgQ0EwHhcNMjIwODAxMDAwMDAwWhcNMzExMTA5MjM1OTU5WjBiMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJvb3QgRzQw
# ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC/5pBzaN675F1KPDAiMGkz
# 7MKnJS7JIT3yithZwuEppz1Yq3aaza57G4QNxDAf8xukOBbrVsaXbR2rsnnyyhHS
# 5F/WBTxSD1Ifxp4VpX6+n6lXFllVcq9ok3DCsrp1mWpzMpTREEQQLt+C8weE5nQ7
# bXHiLQwb7iDVySAdYyktzuxeTsiT+CFhmzTrBcZe7FsavOvJz82sNEBfsXpm7nfI
# SKhmV1efVFiODCu3T6cw2Vbuyntd463JT17lNecxy9qTXtyOj4DatpGYQJB5w3jH
# trHEtWoYOAMQjdjUN6QuBX2I9YI+EJFwq1WCQTLX2wRzKm6RAXwhTNS8rhsDdV14
# Ztk6MUSaM0C/CNdaSaTC5qmgZ92kJ7yhTzm1EVgX9yRcRo9k98FpiHaYdj1ZXUJ2
# h4mXaXpI8OCiEhtmmnTK3kse5w5jrubU75KSOp493ADkRSWJtppEGSt+wJS00mFt
# 6zPZxd9LBADMfRyVw4/3IbKyEbe7f/LVjHAsQWCqsWMYRJUadmJ+9oCw++hkpjPR
# iQfhvbfmQ6QYuKZ3AeEPlAwhHbJUKSWJbOUOUlFHdL4mrLZBdd56rF+NP8m800ER
# ElvlEFDrMcXKchYiCd98THU/Y+whX8QgUWtvsauGi0/C1kVfnSD8oR7FwI+isX4K
# Jpn15GkvmB0t9dmpsh3lGwIDAQABo4IBOjCCATYwDwYDVR0TAQH/BAUwAwEB/zAd
# BgNVHQ4EFgQU7NfjgtJxXWRM3y5nP+e6mK4cD08wHwYDVR0jBBgwFoAUReuir/SS
# y4IxLVGLp6chnfNtyA8wDgYDVR0PAQH/BAQDAgGGMHkGCCsGAQUFBwEBBG0wazAk
# BggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAC
# hjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
# b290Q0EuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
# LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwEQYDVR0gBAowCDAGBgRV
# HSAAMA0GCSqGSIb3DQEBDAUAA4IBAQBwoL9DXFXnOF+go3QbPbYW1/e/Vwe9mqyh
# hyzshV6pGrsi+IcaaVQi7aSId229GhT0E0p6Ly23OO/0/4C5+KH38nLeJLxSA8hO
# 0Cre+i1Wz/n096wwepqLsl7Uz9FDRJtDIeuWcqFItJnLnU+nBgMTdydE1Od/6Fmo
# 8L8vC6bp8jQ87PcDx4eo0kxAGTVGamlUsLihVo7spNU96LHc/RzY9HdaXFSMb++h
# UD38dglohJ9vytsgjTVgHAIDyyCwrFigDkBjxZgiwbJZ9VVrzyerbHbObyMt9H5x
# aiNrIv8SuFQtJ37YOtnwtoeW/VvRXKwYw02fc7cBqZ9Xql4o4rmUMIIGYzCCBEug
# AwIBAgIQeAuTgzemd0ILREkKU+Yq2jANBgkqhkiG9w0BAQsFADBWMQswCQYDVQQG
# EwJQTDEhMB8GA1UEChMYQXNzZWNvIERhdGEgU3lzdGVtcyBTLkEuMSQwIgYDVQQD
# ExtDZXJ0dW0gQ29kZSBTaWduaW5nIDIwMjEgQ0EwHhcNMjQwNDExMDYwMzIxWhcN
# MjUwNDExMDYwMzIwWjCBiDELMAkGA1UEBhMCR0IxDzANBgNVBAgMBkRvcnNldDEU
# MBIGA1UEBwwLQk9VUk5FTU9VVEgxHjAcBgNVBAoMFU9wZW4gU291cmNlIERldmVs
# b3BlcjEyMDAGA1UEAwwpT3BlbiBTb3VyY2UgRGV2ZWxvcGVyLCBBU0hMRVkgTUlD
# SEFFTCBIT1cwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQDpmsgFPzl4
# 7W61kLLEp5ljxHC0ZZDti0+DL2JSAac1+bQW24vSjg4ABHhRB5CDKBuwVe2h0l+G
# mEZHhKc9cz/RB+hUIJycd5Qx6VzsI1KJ0heEECm+oo3rywyqrd9RovkhkU2X29cR
# UAa9SWZJJ2+/ImyzfyxzR+u0DD17BucHXWylQB2HGFCcX3kYUmgyZ/ANrgTvetW+
# n91OLxquC5+Nslh4MhbQAnItX79qrFLODd05S3SpQvdti16WGcRwXka4t5zdAMf6
# v3c8ThHKPm/1TsyWsYAUMYJ9C0sNt+QYKNYHRX7DuA1OJBngAyGggtaXmqEpPBX2
# SkDJ0uOeVDoJEOsxNydGZYPgvkIzsyF8YmEzkPK5x5elglYI0wfGwaMKshVbszj5
# KXIPogeF/0vrEi8iIEd+Ro3ZY8ul+TliYf6P55tl3VCuKHDbzcYCtOXURmAPGwxC
# 9wVvTr946eJr+emejOxg4/BZw5Q5GD6Qr8wwyodqholbzp8bfjTFmC8CAwEAAaOC
# AXgwggF0MAwGA1UdEwEB/wQCMAAwPQYDVR0fBDYwNDAyoDCgLoYsaHR0cDovL2Nj
# c2NhMjAyMS5jcmwuY2VydHVtLnBsL2Njc2NhMjAyMS5jcmwwcwYIKwYBBQUHAQEE
# ZzBlMCwGCCsGAQUFBzABhiBodHRwOi8vY2NzY2EyMDIxLm9jc3AtY2VydHVtLmNv
# bTA1BggrBgEFBQcwAoYpaHR0cDovL3JlcG9zaXRvcnkuY2VydHVtLnBsL2Njc2Nh
# MjAyMS5jZXIwHwYDVR0jBBgwFoAU3XRdTADbe5+gdMqxbvc8wDLAcM0wHQYDVR0O
# BBYEFB7BnDzi+HIrft6IpueXUsx5LcgwMEsGA1UdIAREMEIwCAYGZ4EMAQQBMDYG
# CyqEaAGG9ncCBQEEMCcwJQYIKwYBBQUHAgEWGWh0dHBzOi8vd3d3LmNlcnR1bS5w
# bC9DUFMwEwYDVR0lBAwwCgYIKwYBBQUHAwMwDgYDVR0PAQH/BAQDAgeAMA0GCSqG
# SIb3DQEBCwUAA4ICAQBO5qPmZq+cztnjKtz9DyVBkZGaHj/TmfIZHrYfeQ0zdEVL
# EszgokLuqNDdk0odEUHiockPB2dQn60oE3rNs+Wb1ZLLT18VoQTV0saMD3GiNzil
# ejD4nIrhQ+vt0auxCvzBS8cQd24ePmjTqcIkL/u07xGhtT3LpUHUuHknUcEFjgs0
# bUpGR5bofW8B9ZSC31g2i5PKZH8PUgOrTvg8oaMQYWyduKFnW8JRRGqypjUIFDE0
# N224ox/U6GqqIl2cuC87H7WrHPEO6VjqSOx0PgybhSggGDKRNk9UQN1R45K/NCcw
# 5+sIA1pjTZHnMhIJdxamhXiNq2S0U3LRVLSs1/BuXGENFWUraE4c51kDCiBPpGus
# olI7/LLF3PIyYopyAWOGw0R7snlT+HJbfI7P6ObfYzzmIMdrKSaBkNtautcRYcIT
# HAmbUAVplnpexQXXapSqxUfrPXWZk7xRLSXXqn915NbAoofVrTuLNXbv437KmoaN
# p2J23oE7KzqdkoZ9SO4+8K+XKoEqBrPyxNB/i5UIId1Rsu5GE453usJf7zgsz4Ib
# T8MQXjPq0WageEH3cL3qoPGBVbD++hLCJhqHPFJfM3zqxz4xZIRm7dY7GmcVc3Qq
# H0biPnYkTfe8fwrT/IpEmVPdDnUSM92MhV25HV4CYU5LAISU1B070DMFAGc1uTCC
# Bq4wggSWoAMCAQICEAc2N7ckVHzYR6z9KGYqXlswDQYJKoZIhvcNAQELBQAwYjEL
# MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3
# LmRpZ2ljZXJ0LmNvbTEhMB8GA1UEAxMYRGlnaUNlcnQgVHJ1c3RlZCBSb290IEc0
# MB4XDTIyMDMyMzAwMDAwMFoXDTM3MDMyMjIzNTk1OVowYzELMAkGA1UEBhMCVVMx
# FzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBUcnVz
# dGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQTCCAiIwDQYJKoZI
# hvcNAQEBBQADggIPADCCAgoCggIBAMaGNQZJs8E9cklRVcclA8TykTepl1Gh1tKD
# 0Z5Mom2gsMyD+Vr2EaFEFUJfpIjzaPp985yJC3+dH54PMx9QEwsmc5Zt+FeoAn39
# Q7SE2hHxc7Gz7iuAhIoiGN/r2j3EF3+rGSs+QtxnjupRPfDWVtTnKC3r07G1decf
# BmWNlCnT2exp39mQh0YAe9tEQYncfGpXevA3eZ9drMvohGS0UvJ2R/dhgxndX7RU
# CyFobjchu0CsX7LeSn3O9TkSZ+8OpWNs5KbFHc02DVzV5huowWR0QKfAcsW6Th+x
# tVhNef7Xj3OTrCw54qVI1vCwMROpVymWJy71h6aPTnYVVSZwmCZ/oBpHIEPjQ2OA
# e3VuJyWQmDo4EbP29p7mO1vsgd4iFNmCKseSv6De4z6ic/rnH1pslPJSlRErWHRA
# KKtzQ87fSqEcazjFKfPKqpZzQmiftkaznTqj1QPgv/CiPMpC3BhIfxQ0z9JMq++b
# Pf4OuGQq+nUoJEHtQr8FnGZJUlD0UfM2SU2LINIsVzV5K6jzRWC8I41Y99xh3pP+
# OcD5sjClTNfpmEpYPtMDiP6zj9NeS3YSUZPJjAw7W4oiqMEmCPkUEBIDfV8ju2Tj
# Y+Cm4T72wnSyPx4JduyrXUZ14mCjWAkBKAAOhFTuzuldyF4wEr1GnrXTdrnSDmuZ
# DNIztM2xAgMBAAGjggFdMIIBWTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQW
# BBS6FtltTYUvcyl2mi91jGogj57IbzAfBgNVHSMEGDAWgBTs1+OC0nFdZEzfLmc/
# 57qYrhwPTzAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwgwdwYI
# KwYBBQUHAQEEazBpMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5j
# b20wQQYIKwYBBQUHMAKGNWh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydFRydXN0ZWRSb290RzQuY3J0MEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9j
# cmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRSb290RzQuY3JsMCAGA1Ud
# IAQZMBcwCAYGZ4EMAQQCMAsGCWCGSAGG/WwHATANBgkqhkiG9w0BAQsFAAOCAgEA
# fVmOwJO2b5ipRCIBfmbW2CFC4bAYLhBNE88wU86/GPvHUF3iSyn7cIoNqilp/GnB
# zx0H6T5gyNgL5Vxb122H+oQgJTQxZ822EpZvxFBMYh0MCIKoFr2pVs8Vc40BIiXO
# lWk/R3f7cnQU1/+rT4osequFzUNf7WC2qk+RZp4snuCKrOX9jLxkJodskr2dfNBw
# CnzvqLx1T7pa96kQsl3p/yhUifDVinF2ZdrM8HKjI/rAJ4JErpknG6skHibBt94q
# 6/aesXmZgaNWhqsKRcnfxI2g55j7+6adcq/Ex8HBanHZxhOACcS2n82HhyS7T6NJ
# uXdmkfFynOlLAlKnN36TU6w7HQhJD5TNOXrd/yVjmScsPT9rp/Fmw0HNT7ZAmyEh
# QNC3EyTN3B14OuSereU0cZLXJmvkOHOrpgFPvT87eK1MrfvElXvtCl8zOYdBeHo4
# 6Zzh3SP9HSjTx/no8Zhf+yvYfvJGnXUsHicsJttvFXseGYs2uJPU5vIXmVnKcPA3
# v5gA3yAWTyf7YGcWoWa63VXAOimGsJigK+2VQbc61RWYMbRiCQ8KvYHZE/6/pNHz
# V9m8BPqC3jLfBInwAM1dwvnQI38AC+R2AibZ8GV2QqYphwlHK+Z/GqSFD/yYlvZV
# VCsfgPrA8g4r5db7qS9EFUrnEw4d2zc4GqEr9u3WfPwwgga5MIIEoaADAgECAhEA
# maOACiZVO2Wr3G6EprPqOTANBgkqhkiG9w0BAQwFADCBgDELMAkGA1UEBhMCUEwx
# IjAgBgNVBAoTGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAlBgNVBAsTHkNl
# cnR1bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEkMCIGA1UEAxMbQ2VydHVtIFRy
# dXN0ZWQgTmV0d29yayBDQSAyMB4XDTIxMDUxOTA1MzIxOFoXDTM2MDUxODA1MzIx
# OFowVjELMAkGA1UEBhMCUEwxITAfBgNVBAoTGEFzc2VjbyBEYXRhIFN5c3RlbXMg
# Uy5BLjEkMCIGA1UEAxMbQ2VydHVtIENvZGUgU2lnbmluZyAyMDIxIENBMIICIjAN
# BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnSPPBDAjO8FGLOczcz5jXXp1ur5c
# Tbq96y34vuTmflN4mSAfgLKTvggv24/rWiVGzGxT9YEASVMw1Aj8ewTS4IndU8s7
# VS5+djSoMcbvIKck6+hI1shsylP4JyLvmxwLHtSworV9wmjhNd627h27a8RdrT1P
# H9ud0IF+njvMk2xqbNTIPsnWtw3E7DmDoUmDQiYi/ucJ42fcHqBkbbxYDB7SYOou
# u9Tj1yHIohzuC8KNqfcYf7Z4/iZgkBJ+UFNDcc6zokZ2uJIxWgPWXMEmhu1gMXgv
# 8aGUsRdaCtVD2bSlbfsq7BiqljjaCun+RJgTgFRCtsuAEw0pG9+FA+yQN9n/kZtM
# LK+Wo837Q4QOZgYqVWQ4x6cM7/G0yswg1ElLlJj6NYKLw9EcBXE7TF3HybZtYvj9
# lDV2nT8mFSkcSkAExzd4prHwYjUXTeZIlVXqj+eaYqoMTpMrfh5MCAOIG5knN4Q/
# JHuurfTI5XDYO962WZayx7ACFf5ydJpoEowSP07YaBiQ8nXpDkNrUA9g7qf/rCkK
# bWpQ5boufUnq1UiYPIAHlezf4muJqxqIns/kqld6JVX8cixbd6PzkDpwZo4SlADa
# Ci2JSplKShBSND36E/ENVv8urPS0yOnpG4tIoBGxVCARPCg1BnyMJ4rBJAcOSnAW
# d18Jx5n858JSqPECAwEAAaOCAVUwggFRMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0O
# BBYEFN10XUwA23ufoHTKsW73PMAywHDNMB8GA1UdIwQYMBaAFLahVDkCw6A/joq8
# +tT4HKbROg79MA4GA1UdDwEB/wQEAwIBBjATBgNVHSUEDDAKBggrBgEFBQcDAzAw
# BgNVHR8EKTAnMCWgI6Ahhh9odHRwOi8vY3JsLmNlcnR1bS5wbC9jdG5jYTIuY3Js
# MGwGCCsGAQUFBwEBBGAwXjAoBggrBgEFBQcwAYYcaHR0cDovL3N1YmNhLm9jc3At
# Y2VydHVtLmNvbTAyBggrBgEFBQcwAoYmaHR0cDovL3JlcG9zaXRvcnkuY2VydHVt
# LnBsL2N0bmNhMi5jZXIwOQYDVR0gBDIwMDAuBgRVHSAAMCYwJAYIKwYBBQUHAgEW
# GGh0dHA6Ly93d3cuY2VydHVtLnBsL0NQUzANBgkqhkiG9w0BAQwFAAOCAgEAdYhY
# D+WPUCiaU58Q7EP89DttyZqGYn2XRDhJkL6P+/T0IPZyxfxiXumYlARMgwRzLRUS
# tJl490L94C9LGF3vjzzH8Jq3iR74BRlkO18J3zIdmCKQa5LyZ48IfICJTZVJeChD
# UyuQy6rGDxLUUAsO0eqeLNhLVsgw6/zOfImNlARKn1FP7o0fTbj8ipNGxHBIutiR
# sWrhWM2f8pXdd3x2mbJCKKtl2s42g9KUJHEIiLni9ByoqIUul4GblLQigO0ugh7b
# WRLDm0CdY9rNLqyA3ahe8WlxVWkxyrQLjH8ItI17RdySaYayX3PhRSC4Am1/7mAT
# wZWwSD+B7eMcZNhpn8zJ+6MTyE6YoEBSRVrs0zFFIHUR08Wk0ikSf+lIe5Iv6RY3
# /bFAEloMU+vUBfSouCReZwSLo8WdrDlPXtR0gicDnytO7eZ5827NS2x7gCBibESY
# kOh1/w1tVxTpV2Na3PR7nxYVlPu1JPoRZCbH86gc96UTvuWiOruWmyOEMLOGGniR
# +x+zPF/2DaGgK2W1eEJfo2qyrBNPvF7wuAyQfiFXLwvWHamoYtPZo0LHuH8X3n9C
# +xN4YaNjt2ywzOr+tKyEVAotnyU9vyEVOaIYMk3IeBrmFnn0gbKeTTyYeEEUz/Qw
# t4HOUBCrW602NCmvO1nm+/80nLy5r0AZvCQxaQ4wgga8MIIEpKADAgECAhALrma8
# Wrp/lYfG+ekE4zMEMA0GCSqGSIb3DQEBCwUAMGMxCzAJBgNVBAYTAlVTMRcwFQYD
# VQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMyRGlnaUNlcnQgVHJ1c3RlZCBH
# NCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcgQ0EwHhcNMjQwOTI2MDAwMDAw
# WhcNMzUxMTI1MjM1OTU5WjBCMQswCQYDVQQGEwJVUzERMA8GA1UEChMIRGlnaUNl
# cnQxIDAeBgNVBAMTF0RpZ2lDZXJ0IFRpbWVzdGFtcCAyMDI0MIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAvmpzn/aVIauWMLpbbeZZo7Xo/ZEfGMSIO2qZ
# 46XB/QowIEMSvgjEdEZ3v4vrrTHleW1JWGErrjOL0J4L0HqVR1czSzvUQ5xF7z4I
# Qmn7dHY7yijvoQ7ujm0u6yXF2v1CrzZopykD07/9fpAT4BxpT9vJoJqAsP8YuhRv
# flJ9YeHjes4fduksTHulntq9WelRWY++TFPxzZrbILRYynyEy7rS1lHQKFpXvo2G
# ePfsMRhNf1F41nyEg5h7iOXv+vjX0K8RhUisfqw3TTLHj1uhS66YX2LZPxS4oaf3
# 3rp9HlfqSBePejlYeEdU740GKQM7SaVSH3TbBL8R6HwX9QVpGnXPlKdE4fBIn5BB
# FnV+KwPxRNUNK6lYk2y1WSKour4hJN0SMkoaNV8hyyADiX1xuTxKaXN12HgR+8Wu
# lU2d6zhzXomJ2PleI9V2yfmfXSPGYanGgxzqI+ShoOGLomMd3mJt92nm7Mheng/T
# BeSA2z4I78JpwGpTRHiT7yHqBiV2ngUIyCtd0pZ8zg3S7bk4QC4RrcnKJ3FbjyPA
# GogmoiZ33c1HG93Vp6lJ415ERcC7bFQMRbxqrMVANiav1k425zYyFMyLNyE1QulQ
# SgDpW9rtvVcIH7WvG9sqYup9j8z9J1XqbBZPJ5XLln8mS8wWmdDLnBHXgYly/p1D
# hoQo5fkCAwEAAaOCAYswggGHMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAA
# MBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMCAGA1UdIAQZMBcwCAYGZ4EMAQQCMAsG
# CWCGSAGG/WwHATAfBgNVHSMEGDAWgBS6FtltTYUvcyl2mi91jGogj57IbzAdBgNV
# HQ4EFgQUn1csA3cOKBWQZqVjXu5Pkh92oFswWgYDVR0fBFMwUTBPoE2gS4ZJaHR0
# cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0UlNBNDA5NlNI
# QTI1NlRpbWVTdGFtcGluZ0NBLmNybDCBkAYIKwYBBQUHAQEEgYMwgYAwJAYIKwYB
# BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBYBggrBgEFBQcwAoZMaHR0
# cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0UlNBNDA5
# NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAPa0e
# H3aZW+M4hBJH2UOR9hHbm04IHdEoT8/T3HuBSyZeq3jSi5GXeWP7xCKhVireKCnC
# s+8GZl2uVYFvQe+pPTScVJeCZSsMo1JCoZN2mMew/L4tpqVNbSpWO9QGFwfMEy60
# HofN6V51sMLMXNTLfhVqs+e8haupWiArSozyAmGH/6oMQAh078qRh6wvJNU6gnh5
# OruCP1QUAvVSu4kqVOcJVozZR5RRb/zPd++PGE3qF1P3xWvYViUJLsxtvge/mzA7
# 5oBfFZSbdakHJe2BVDGIGVNVjOp8sNt70+kEoMF+T6tptMUNlehSR7vM+C13v9+9
# ZOUKzfRUAYSyyEmYtsnpltD/GWX8eM70ls1V6QG/ZOB6b6Yum1HvIiulqJ1Elesj
# 5TMHq8CWT/xrW7twipXTJ5/i5pkU5E16RSBAdOp12aw8IQhhA/vEbFkEiF2abhuF
# ixUDobZaA0VhqAsMHOmaT3XThZDNi5U2zHKhUs5uHHdG6BoQau75KiNbh0c+hatS
# F+02kULkftARjsyEpHKsF7u5zKRbt5oK5YGwFvgc4pEVUNytmB3BpIiowOIIuDgP
# 5M9WArHYSAR16gc0dP2XdkMEP5eBsX7bf/MGN4K3HP50v/01ZHo/Z5lGLvNwQ7XH
# Bx1yomzLP8lx4Q1zZKDyHcp4VQJLu2kWTsKsOqQxggWvMIIFqwIBATBqMFYxCzAJ
# BgNVBAYTAlBMMSEwHwYDVQQKExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xJDAi
# BgNVBAMTG0NlcnR1bSBDb2RlIFNpZ25pbmcgMjAyMSBDQQIQeAuTgzemd0ILREkK
# U+Yq2jAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUz9OLOGWKglRuJupnP5XtDFUZmRwwDQYJKoZI
# hvcNAQEBBQAEggGAciecR+FXEGzbXGR5MeXXtyZkebgMyJ8JBPJ6pG37kLEm2g00
# qA29IOctGbOsSpQram6zh5ds6/RorG/dW8cOPKlq+/wzoDnddG3EWJWdPmfZGno9
# 7RBajmmo9zXtsmvPJ5Jx+RluMckfkKgAKO1FfPUJOJgKuO8jCqcTdtkZMkPJbvxp
# fLz71wV7YT39LUpg4FCTdI/oqT6+IKqaINfDJ385SKRFQ1F9EuQPN23Nkht65wGd
# q5Aau8oLcXpB92X04GnbQ1X0pUc6y8Oye/hjo4u6NnRcE/sxyVnaK5TlWAEnDyw3
# eN8VhCOOnUhZYItJ2U4CkQrRpYltLdTJ+bVqvch8T9mAc443sNTz/Ndi86TYQ+b2
# P0eqQ2a68KSlq0Tst00LCaEm031TiKiD5HxF5CI5rdhcgUCm4JymeqgBn3pDjeAS
# xvV+6Z6O/4T//s2Cz8K6wg5NM6TLdYT3EXBZp6RD65AIjsBKAhACAJhM4mr6gb9W
# fqaZciRB+Io3KIn1oYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEBMHcwYzEL
# MAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJE
# aWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBD
# QQIQC65mvFq6f5WHxvnpBOMzBDANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAxMTAwMjIxMFowLwYJ
# KoZIhvcNAQkEMSIEIGjwxQPRLghgr1AKzo1FEX8vqv727GuvBwidW7cTWpz2MA0G
# CSqGSIb3DQEBAQUABIICAGFTWfGcm7vxB7iuXCl1CIT8oB5RO08l+AKFigTyvnLp
# fOvVjuHb05Cv7g0tg7yjWpSgFPlb7L7fP1lG1lsyEygDMcB1JEqzStBctYioLpLb
# Q9WP/ba6pkzmlpTFxoRGTLDYBTwxVhI4mVr2SvYQo9GyOwanfFZIyNuQfMVakJ1j
# cf0QkP7m/FGtT9OOBL/kVV8764dPiyhXhrNBBNoGrauwfXNu31u1DFJ7HQbD/txO
# 2xKudn8UmRLqxjT7EHzm8RwOT/n89Yfm8FQ2btTPLfskTyXVXp5hFflFPCumtkkh
# FYhCmTJPC05aOSOqkFGHQLH8MONyuKM8jQ7davl/fxzCqGYJ1ylFKPsbHN3KfPlo
# kSLkHHgT9kJFAJ9ou3r8igzefpy5ShbLehv5Y/LaXWUWZPOg8bgmo+CLybFYrfpZ
# BIvUu6pgYz8z357jmY/DjhR0ebP0Q4NzvsDgLtVgYSO7U+j7e7hsCUUqZHaM+Yrm
# oHLx6OCRokzkCg5X9bthaH5aYjVpqZ6ao5W/ITr6Uwc3OMsUYoWgvqx5KIin8mro
# jIHjp4pDSEv2aTxX+KtAQQ9v7iKlvBsnM5z/y2NcnezLakFsC+bhZuqxaSCvxuTv
# KqpZcHY926MUGQZVeI95a2JwXaEtTFyYhn+lcZ9yCPctKR00djCZDtW170LWHer8
# SIG # End signature block
