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
    If ($CurrentVersion -or $args.Length -eq 0) {
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
# MIImcgYJKoZIhvcNAQcCoIImYzCCJl8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUssDaYfcaEd/ekZrKrTBqE0jP
# NxOggiAtMIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkqhkiG9w0B
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
# t4HOUBCrW602NCmvO1nm+/80nLy5r0AZvCQxaQ4wggbCMIIEqqADAgECAhAFRK/z
# lJ0IOaa/2z9f5WEWMA0GCSqGSIb3DQEBCwUAMGMxCzAJBgNVBAYTAlVTMRcwFQYD
# VQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMyRGlnaUNlcnQgVHJ1c3RlZCBH
# NCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcgQ0EwHhcNMjMwNzE0MDAwMDAw
# WhcNMzQxMDEzMjM1OTU5WjBIMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNl
# cnQsIEluYy4xIDAeBgNVBAMTF0RpZ2lDZXJ0IFRpbWVzdGFtcCAyMDIzMIICIjAN
# BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAo1NFhx2DjlusPlSzI+DPn9fl0udd
# oQ4J3C9Io5d6OyqcZ9xiFVjBqZMRp82qsmrdECmKHmJjadNYnDVxvzqX65RQjxwg
# 6seaOy+WZuNp52n+W8PWKyAcwZeUtKVQgfLPywemMGjKg0La/H8JJJSkghraarrY
# O8pd3hkYhftF6g1hbJ3+cV7EBpo88MUueQ8bZlLjyNY+X9pD04T10Mf2SC1eRXWW
# df7dEKEbg8G45lKVtUfXeCk5a+B4WZfjRCtK1ZXO7wgX6oJkTf8j48qG7rSkIWRw
# 69XloNpjsy7pBe6q9iT1HbybHLK3X9/w7nZ9MZllR1WdSiQvrCuXvp/k/XtzPjLu
# UjT71Lvr1KAsNJvj3m5kGQc3AZEPHLVRzapMZoOIaGK7vEEbeBlt5NkP4FhB+9ix
# LOFRr7StFQYU6mIIE9NpHnxkTZ0P387RXoyqq1AVybPKvNfEO2hEo6U7Qv1zfe7d
# Cv95NBB+plwKWEwAPoVpdceDZNZ1zY8SdlalJPrXxGshuugfNJgvOuprAbD3+yqG
# 7HtSOKmYCaFxsmxxrz64b5bV4RAT/mFHCoz+8LbH1cfebCTwv0KCyqBxPZySkwS0
# aXAnDU+3tTbRyV8IpHCj7ArxES5k4MsiK8rxKBMhSVF+BmbTO77665E42FEHypS3
# 4lCh8zrTioPLQHsCAwEAAaOCAYswggGHMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMB
# Af8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMCAGA1UdIAQZMBcwCAYGZ4EM
# AQQCMAsGCWCGSAGG/WwHATAfBgNVHSMEGDAWgBS6FtltTYUvcyl2mi91jGogj57I
# bzAdBgNVHQ4EFgQUpbbvE+fvzdBkodVWqWUxo97V40kwWgYDVR0fBFMwUTBPoE2g
# S4ZJaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0UlNB
# NDA5NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNybDCBkAYIKwYBBQUHAQEEgYMwgYAw
# JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBYBggrBgEFBQcw
# AoZMaHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0
# UlNBNDA5NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNydDANBgkqhkiG9w0BAQsFAAOC
# AgEAgRrW3qCptZgXvHCNT4o8aJzYJf/LLOTN6l0ikuyMIgKpuM+AqNnn48XtJoKK
# cS8Y3U623mzX4WCcK+3tPUiOuGu6fF29wmE3aEl3o+uQqhLXJ4Xzjh6S2sJAOJ9d
# yKAuJXglnSoFeoQpmLZXeY/bJlYrsPOnvTcM2Jh2T1a5UsK2nTipgedtQVyMadG5
# K8TGe8+c+njikxp2oml101DkRBK+IA2eqUTQ+OVJdwhaIcW0z5iVGlS6ubzBaRm6
# zxbygzc0brBBJt3eWpdPM43UjXd9dUWhpVgmagNF3tlQtVCMr1a9TMXhRsUo063n
# QwBw3syYnhmJA+rUkTfvTVLzyWAhxFZH7doRS4wyw4jmWOK22z75X7BC1o/jF5HR
# qsBV44a/rCcsQdCaM0qoNtS5cpZ+l3k4SF/Kwtw9Mt911jZnWon49qfH5U81PAC9
# vpwqbHkB3NpE5jreODsHXjlY9HxzMVWggBHLFAx+rrz+pOt5Zapo1iLKO+uagjVX
# KBbLafIymrLS2Dq4sUaGa7oX/cR3bBVsrquvczroSUa31X/MtjjA2Owc9bahuEMs
# 305MfR5ocMB3CtQC4Fxguyj/OOVSWtasFyIjTvTs0xf7UGv/B3cfcZdEQcm4RtNs
# MnxYL2dHZeUbc7aZ+WssBkbvQR7w8F/g29mtkIBEr4AQQYoxggWvMIIFqwIBATBq
# MFYxCzAJBgNVBAYTAlBMMSEwHwYDVQQKExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMu
# QS4xJDAiBgNVBAMTG0NlcnR1bSBDb2RlIFNpZ25pbmcgMjAyMSBDQQIQeAuTgzem
# d0ILREkKU+Yq2jAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKA
# ADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYK
# KwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUPpExI4U6y+Tz1g95tecTm8YDyXow
# DQYJKoZIhvcNAQEBBQAEggGAAIwDElXlhvVJcuU9gWCHRV6oVaHi0aVvEnq1jOI8
# HqMN+sunnpdxHOn29cMTeqzM6iphu6C5q3jXMt76YhfZlGC1TOdGKdDarhhgKnmE
# eiMQ49ByJhmpbc/8f4Bn5Leq8YdypSxyV+CBX++L2CcNTc1y/qOYD4MpKgp6c+aH
# DypF0b5whZFWDOrbkJOQoe9ZFv7JePZzNQ7fYuz/O3D5Q1x0ugr26TcjWAOnCRBh
# Hyyze+6b0Pg79C3msA608kQxTOj6FKgTxU6sFv3RKx42VdPtP3k8ULVI2+5VQRrT
# ImrN73EYIfDVBe4Lic+aW6EGMOd1e+x2W+Ej2Y1RewemxuY6s+wq3NZ1IjzrTn9Z
# TZ9ZDhAPJ+vCfwCJiNs0hZxbkzHFM6Cv1U35h3QJdLHowJMjQaG6+YlnXwONbhvL
# yQ2ZDvCervw4jwTWE/IKFEnYfqN4gLuEsi1wuMFEiyLac0F8EOS6qHFPKlM5fyGW
# 0Q6OZyxscTjZh44dQZ5No3qzoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEB
# MHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYD
# VQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFt
# cGluZyBDQQIQBUSv85SdCDmmv9s/X+VhFjANBglghkgBZQMEAgEFAKBpMBgGCSqG
# SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNTIzMTE1
# NlowLwYJKoZIhvcNAQkEMSIEIOZFaprlrKvdtFK7BcURERtD8yKZdRg7InzfiMWw
# QFM0MA0GCSqGSIb3DQEBAQUABIICAHKJGOuiRAEeUXFJKFDYPS7s1LkfRg2dLrwl
# 2K0NfGzdeebrvfvWnMIQNfz+BK4D4jl1bUowOSngOP2iqIXH67UB37ew4zgi7ai5
# XZehcUYQCtjJrQ3LUDgtRr51JS+pSmn/SkVVzYwRy9a2770RDHQzSvL7AgXt66nl
# uhOqYOOgoCVvUbXiLV/wSYlHXGQsS1nUV5FEOafwDAZYwYkOm+t597VEM5+tsPgo
# Nn6t2LCzTrRrVptB6YudbaZFusILjjo/ZxOM+w7UhdGv5OunOQYkTtRLVrX1aPaM
# pqqHFUUL4X5RFZpW/3V9fS3thk42XcY5NXmqgPCf+nI29WuPKfg/hb1/vexJHIxc
# v/GDTIMkZfu9LZtrD1OelAtFdjPproiopRifDXxEDjA4S/UebERggBIkMugo0Wyq
# WWzxAHPTCplogafktCN97xA5WxswRe43AIGmqawTN03uXOzsHOIhhfQSxK4MSpIv
# su5JaTb5Ah273FscXIsVEo4yv8zTBhfdlIs/QocdzutKaL4UbVPqRcEy5jHfvyTE
# 7d2EcZse+Y+zFvhqZR7Hf0uY4bawl/DwoUSE4M8RMyMI2HWWNtc/nH550vKsVpFA
# kMpPCGQXq99AkNPF6FkfJqiryeep4qJXBC0CE05p6fGx67n7NWitQmug3z0mg0Ng
# iWbWbgOQ
# SIG # End signature block
