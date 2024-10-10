BeforeAll {
    $Path =  (Get-Item $PsScriptRoot).parent.FullName + "\WindowsOSServicing.psm1"
    . Import-Module -Name $Path -Verbose
}

If ($PSVersionTable.PSVersion.Major -le 6) {
    Describe "PS - Get-WindowsServicing" {
        Context "Microsoft Windows 10 Home" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Home" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Home"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Pro" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Pro for Workstations" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro for Workstations" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro for Workstations"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Pro Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Business" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Business" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Business"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 10 IoT Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 IoT Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 IoT Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-iot-enterprise"
            }
        }
        Context "Microsoft Windows 10 Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 10 Pro Enterprise multi-session" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise multi-session" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise multi-session"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 11 Home" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Home" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Home"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Pro" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Pro for Workstations" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro for Workstations" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro for Workstations"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Pro Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro Education" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro Education"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Business" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Business" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Business"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 11 IoT Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 IoT Enterprise" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 IoT Enterprise"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-iot-enterprise"
            }
        }
        Context "Microsoft Windows 11 Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Education" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Education"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 11 Pro Enterprise multi-session" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise multi-session" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise multi-session"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 10 Enterprise 2015 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Version | Should -Be "1507"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2015-ltsb"
            }
        }
        Context "Microsoft Windows 10 Enterprise 2016 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Version | Should -Be "1607"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2016-ltsb"
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Version | Should -Be "1809"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2019"
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2021" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Version | Should -Be "21H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2021"
            }
        }
        Context "Microsoft Windows 10 IoT Enterprise LTSC 2021" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 IoT Enterprise LTSC 2021"
                $Results.Name | Should -Be "Microsoft Windows 10 IoT Enterprise LTSC 2021"
                $Results.Version | Should -Be "21H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-iot-enterprise-ltsc-2021"
            }
        }
        Context "Microsoft Windows Server 2016" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2016"
                $Results.Name | Should -Be "Microsoft Windows Server 2016"
                $Results.Version | Should -Be "1607"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2016"
            }
        }
        Context "Microsoft Windows Server 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2019"
                $Results.Name | Should -Be "Microsoft Windows Server 2019"
                $Results.Version | Should -Be "1809"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2019"
            }
        }
        Context "Microsoft Windows Server 2022" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2022"
                $Results.Name | Should -Be "Microsoft Windows Server 2022"
                $Results.Version | Should -Be "21H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2022"
            }
        }
        Context "Microsoft Windows Server Standard" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server Standard" -Version "20H2"
                $Results.Name | Should -Be "Microsoft Windows Server Standard"
                $Results.Version | Should -Be "20H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server"
            }
        }
        Context "Microsoft Windows Server Datacenter" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server Datacenter" -Version "20H2"
                $Results.Name | Should -Be "Microsoft Windows Server Datacenter"
                $Results.Version | Should -Be "20H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server"
            }
        }
        Context "CurrentVersion" {
            It "Results" {
                $Results = Get-WindowsServicing -CurrentVersion
                $Results.Name | Should -Not -BeNullOrEmpty
                $Results.Version | Should -Not -BeNullOrEmpty
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Describe "Code Signing Certificate Test - WindowsOSServicing.psm1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\WindowsOSServicing.psm1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType| Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - WindowsOSServicing.psd1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\WindowsOSServicing.psd1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType| Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - Get-WindowsServicing.ps1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\Public\Get-WindowsServicing.ps1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType| Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - Import-HtmlAgilityPack.ps1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\Private\Import-HtmlAgilityPack.ps1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType| Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - WindowOSServicing.Tests.ps1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\CI\WindowOSServicing.Tests.ps1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType| Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
    }
}
Else {
    Describe "PWSH - Get-WindowsServicing" {
        Context "Microsoft Windows 10 Home" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Home" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Home"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Pro" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Pro for Workstations" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro for Workstations" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro for Workstations"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Pro Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Business" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Business" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Business"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro"
            }
        }
        Context "Microsoft Windows 10 Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 10 IoT Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 IoT Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 IoT Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-iot-enterprise"
            }
        }
        Context "Microsoft Windows 10 Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 10 Pro Enterprise multi-session" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise multi-session" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise multi-session"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 11 Home" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Home" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Home"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Pro" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Pro for Workstations" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro for Workstations" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro for Workstations"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Pro Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro Education" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro Education"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Business" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Business" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Business"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-home-and-pro"
            }
        }
        Context "Microsoft Windows 11 Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 11 IoT Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 IoT Enterprise" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 IoT Enterprise"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-iot-enterprise"
            }
        }
        Context "Microsoft Windows 11 Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Education" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Education"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 11 Pro Enterprise multi-session" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise multi-session" -Version "23H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise multi-session"
                $Results.Version | Should -Be "23H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-11-enterprise-and-education"
            }
        }
        Context "Microsoft Windows 10 Enterprise 2015 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Version | Should -Be "1507"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2015-ltsb"
            }
        }
        Context "Microsoft Windows 10 Enterprise 2016 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Version | Should -Be "1607"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-2016-ltsb"
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Version | Should -Be "1809"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2019"
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2021" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Version | Should -Be "21H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-ltsc-2021"
            }
        }
        Context "Microsoft Windows 10 IoT Enterprise LTSC 2021" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 IoT Enterprise LTSC 2021"
                $Results.Name | Should -Be "Microsoft Windows 10 IoT Enterprise LTSC 2021"
                $Results.Version | Should -Be "21H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-10-iot-enterprise-ltsc-2021"
            }
        }
        Context "Microsoft Windows Server 2016" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2016"
                $Results.Name | Should -Be "Microsoft Windows Server 2016"
                $Results.Version | Should -Be "1607"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2016"
            }
        }
        Context "Microsoft Windows Server 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2019"
                $Results.Name | Should -Be "Microsoft Windows Server 2019"
                $Results.Version | Should -Be "1809"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2019"
            }
        }
        Context "Microsoft Windows Server 2022" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2022"
                $Results.Name | Should -Be "Microsoft Windows Server 2022"
                $Results.Version | Should -Be "21H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server-2022"
            }
        }
        Context "Microsoft Windows Server Standard" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server Standard" -Version "20H2"
                $Results.Name | Should -Be "Microsoft Windows Server Standard"
                $Results.Version | Should -Be "20H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server"
            }
        }
        Context "Microsoft Windows Server Datacenter" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server Datacenter" -Version "20H2"
                $Results.Name | Should -Be "Microsoft Windows Server Datacenter"
                $Results.Version | Should -Be "20H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Be "https://learn.microsoft.com/en-us/lifecycle/products/windows-server"
            }
        }
        Context "CurrentVersion" {
            It "Results" {
                $Results = Get-WindowsServicing -CurrentVersion
                $Results.Name | Should -Not -BeNullOrEmpty
                $Results.Version | Should -Not -BeNullOrEmpty
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Describe "Code Signing Certificate Test - WindowsOSServicing.psm1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\WindowsOSServicing.psm1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType | Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - WindowsOSServicing.psd1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\WindowsOSServicing.psd1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType | Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - Get-WindowsServicing.ps1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\Public\Get-WindowsServicing.ps1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType | Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - Import-HtmlAgilityPack.ps1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\Private\Import-HtmlAgilityPack.ps1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType | Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
        Describe "Code Signing Certificate Test - WindowOSServicing.Tests.ps1" {
            Context "File Signature Check" {
                It "Results" {
                    $signature = Get-AuthenticodeSignature -FilePath "$((Split-Path -Path $PSScriptRoot -Parent).TrimEnd('\'))\CI\WindowOSServicing.Tests.ps1"
                    $signature | Should -Not -BeNullOrEmpty
                    $signature.SignatureType | Should -Be "Authenticode"
                    $signature.Status | Should -Be "Valid"
                }
            }
        }
    }
}
# SIG # Begin signature block
# MIImbAYJKoZIhvcNAQcCoIImXTCCJlkCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQURSbDvTjQ56tcUsW9n10+82bT
# gLKggiAnMIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUCqmfNaqw5ZCuZHr3xE2CPKGQl84wDQYJKoZI
# hvcNAQEBBQAEggGAQm/L7CdumKdJSibZjDYlo7I9djLn7Cj8tHFwaa6Hn+RtxR2k
# 9vKb7ZQ/ZI4IUPmcoo44yKFYrSB7rTn/Ek29o64x5bMMu/qHsOFOxqDdOMMX0HmQ
# 7nKVsFOeo8WrczBlS66T3Vjg4be/aV4E8qH4IgFIREehFbWGVekh23SxYO3vYucg
# /IU6I3sHIRAuij1YGr/0i61IIJSj8F4hW7rMAMAmhwjXgvn/NaYfdnJr6uYXd3hc
# pv3TJWSvoMQWrWGnfVGydEsjzWrHBrv0v0YN4lUqqfKzqTxkqYAPtd4fu2H3o2/u
# ltt3iXW0gDcJsaT7i/y1YTJA3pMNEGjxsVfg8uSvagWUJ4JtnM3mMj18l1Vn2QRB
# US7yMvFZWs86bqhAgChnZIql0myACJuzPtDBiiR2dTOJTnhesqJemVDCg3AvKfVX
# ob+q3loh1JYhn6WT7ARnc7eJ1BucyczTh7+dmSRnudkgP3KNDvY2JR/3qi7twRWo
# 09PQUz1hSWnVTi0eoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEBMHcwYzEL
# MAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJE
# aWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBD
# QQIQC65mvFq6f5WHxvnpBOMzBDANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAxMDE5NDczN1owLwYJ
# KoZIhvcNAQkEMSIEIDSa82u0JGrt4cEmAsv1WqDOGu69rg0R/Lp9E5J/RVhXMA0G
# CSqGSIb3DQEBAQUABIICAIW1+f07/faV+uzv1LGm7CWndIlP7/uBd83MhMMrTCpI
# HqaYtV+W3HwKqZaBb19R2F/w0nlqiaQe6BaJzAqdEzUEiO8OPfNV96vjM0AEiBdD
# DlU9Ehx+YGvCsnNeKtMuRN2jLi6XN02xCeAdBy+wBTQWv+MR+e7qIoT1oYVPwMqA
# CF87C4lnwM/QAAcwUMO5ElYA9Aed4ZmUhB2UVCPqFQRMcY4t4G/nriQuWc+4y3tU
# FGSKvp9hwQPIc37GxX+scmWDxfg10e7p8nP2wjCJrAAEZlZ/0CJFtTEco9WE+XdU
# Ve1ZZJXL3zlXTr/KL3fk6njQKqMEh7hkjH3cvs6G/4tDRwc3KO8RQ+QG1neWsBhT
# jF5RNvnqXDvtchwTpCDZS66/MD6G3LlWzz9ZoANU4RmFYklrjJMHyFi6BX8ixJbw
# rrxedMEohzOpgZgvTISSdc7unlzYzuMEEiVgc07RRTN4HMC4Az6lD3TV9Hw8qN3V
# XO00UzmhCWCpRIaBqUhbMsWgGoeDY4CeJBHc3aWFw/RoHoEl9rWyZ17Iim2yAtCG
# CP0Fi4SZY156fapju1TMNGzsyJW/AEAQn8DqyFfY0vVBS5MdM0nkRR98C0eiSEhu
# 6ysgsh22xWJ4cfrWzUgahORkxvZDRQrldEs9cssNJ9VU1nmKoP+kKdbqB4PVvHeD
# SIG # End signature block
