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
                                                - Windows 10 Education
                                                - Windows 10 Enterprise multi-session

                                                - Windows 10 Enterprise 2015 LTSB
                                                - Windows 10 Enterprise 2016 LTSB
                                                - Windows 10 Enterprise LTSC 2019
                                                - Windows 10 Enterprise LTSC 2021

                                                - Windows 11 Home
                                                - Windows 11 Pro
                                                - Windows 11 Pro for Workstations
                                                - Windows 11 Pro Education
                                                - Windows 11 Business
                                                - Windows 11 Enterprise
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
                '*Windows 10 Education*',
                '*Windows 10 Enterprise multi-session*',
                '*Windows 11 Home*',
                '*Windows 11 Pro*',
                '*Windows 11 Pro for Workstations*',
                '*Windows 11 Pro Education*',
                '*Windows 11 Business*',
                '*Windows 11 Enterprise*',
                '*Windows 11 Education*',
                '*Windows 11 Enterprise multi-session*',
                '*Windows 10 Enterprise 2015 LTSB*',
                '*Windows 10 Enterprise 2016 LTSB*',
                '*Windows 10 Enterprise LTSC 2019*',
                '*Windows 10 Enterprise LTSC 2021*',
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
    If ([String]::IsNullOrEmpty($Caption)) {
        Try {
            $Caption = (Get-CIMInstance Win32_OperatingSystem).Caption
        }
        Catch {
            Throw "Get-OSServicing: Unable to detect Operating System. Error: $($_.Exception.Message)"
        }
    }

    # Find Windows name/caption and set variables
    If ($Caption -match "Windows 10 Enterprise 2015 LTSB") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2015-ltsb"
        $TargetVersion = "NA"
        $TargetListing = "Windows 10 2015 LTSB"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows 10 Enterprise 2016 LTSB") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2016-ltsb"
        $TargetVersion = "NA"
        $TargetListing = "Windows 10 2016 LTSB"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows 10 Enterprise LTSC 2019") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2019"
        $TargetVersion = "NA"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows 10 Enterprise LTSC 2021")  {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2021"
        $TargetVersion = "NA"
        $SecondTableNo = 0
        $EndDateColNo = 2
    }
    ElseIf (($Caption -match "Windows 10 Home") -or ($Caption -match "Windows 10 Pro") -or ($Caption -match "Windows 10 Business")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -notmatch $Caption)) {
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
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -notmatch $Caption)) {
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
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -notmatch $Caption)) {
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
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -notmatch $Caption)) {
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
        $TargetVersion = "NA"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows Server 2019") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2019"
        $TargetVersion = "NA"
        $SecondTableNo = 0
        $EndDateColNo = 3
    }
    ElseIf ($Caption -match "Windows Server 2022") {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2022"
        $TargetVersion = "NA"
        $SecondTableNo = 0
        $EndDateColNo = 2
    }
    ElseIf (($Caption -match "Windows Server Standard") -or ($Caption -match "Windows Server Datacenter")) {
        $LifecycleURL = "https://learn.microsoft.com/en-us/lifecycle/products/windows-server"
        If (![String]::IsNullOrEmpty($Version)) {
            $TargetVersion = $Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -match $Caption)) {
            $TargetVersion = Get-Version
        }
        ElseIf (($CurrentVersion -eq $true) -and ((Get-CIMInstance Win32_OperatingSystem).Caption -notmatch $Caption)) {
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
                    ($Caption -like "*$WebpageListing*"))            # Caption match to WebpageListing
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