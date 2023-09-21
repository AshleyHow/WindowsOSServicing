BeforeAll {
    $Path =  (Get-Item $PsScriptRoot).parent.FullName + "\WindowOSServicing.psm1"
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro for Workstations" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro for Workstations" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro for Workstations"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro Enterprise multi-session" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise multi-session" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise multi-session"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }

        Context "Microsoft Windows 10 Enterprise 2015 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Enterprise 2016 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2021" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows Server 2016" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2016"
                $Results.Name | Should -Be "Microsoft Windows Server 2016"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows Server 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2019"
                $Results.Name | Should -Be "Microsoft Windows Server 2019"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows Server 2022" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2022"
                $Results.Name | Should -Be "Microsoft Windows Server 2022"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Pro Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Pro Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 10 Pro Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro for Workstations" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro for Workstations" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro for Workstations"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro Enterprise" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Pro Enterprise" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Pro Enterprise"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Education" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Education" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Education"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 11 Pro Enterprise multi-session" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 11 Enterprise multi-session" -Version "22H2"
                $Results.Name | Should -Be "Microsoft Windows 11 Enterprise multi-session"
                $Results.Version | Should -Be "22H2"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }

        Context "Microsoft Windows 10 Enterprise 2015 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2015 LTSB"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Enterprise 2016 LTSB" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise 2016 LTSB"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2019"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows 10 Enterprise LTSC 2021" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Name | Should -Be "Microsoft Windows 10 Enterprise LTSC 2021"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows Server 2016" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2016"
                $Results.Name | Should -Be "Microsoft Windows Server 2016"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows Server 2019" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2019"
                $Results.Name | Should -Be "Microsoft Windows Server 2019"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
            }
        }
        Context "Microsoft Windows Server 2022" {
            It "Results" {
                $Results = Get-WindowsServicing -Caption "Microsoft Windows Server 2022"
                $Results.Name | Should -Be "Microsoft Windows Server 2022"
                $Results.Version | Should -Be "NA"
                $Results.'Service start date' | Should -Not -BeNullOrEmpty
                $Results.'Service end date' | Should -Not -BeNullOrEmpty
                $Results.'Serviced' | Should -Not -BeNullOrEmpty
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
                $Results.'Lifecycle Policy URL' | Should -Not -BeNullOrEmpty
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
    }
}