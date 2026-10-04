#InModuleScope is resolved during Pester's discovery phase, so the module must be imported here
#rather than from BeforeAll, which does not run until the later run phase.

#Get Current Directory
$Here = Split-Path -Parent $PSCommandPath

#Module Name
$ModuleName = 'GhCID'

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

Describe $($PSCommandPath -Replace '.Tests.ps1') {

	Context 'Classes' {

		It 'loads ScriptsToProcess classes for the caller' {

			[GhCIDItem]::new('Item').Name | Should -Be -ExpectedValue 'Item'

		}

		It 'loads ScriptsToProcess classes for the module' {

			InModuleScope 'GhCID' { [GhCIDItem]::new('Item').Name } | Should -Be -ExpectedValue 'Item'

		}

	}

	InModuleScope 'GhCID' {

		Context 'Input' {

			It 'returns true for a scope below 5' {

				Test-PublicFile -Scope 1 | Should -Be -ExpectedValue $true

			}

			It 'returns false for a scope of 5 or above' {

				Test-PublicFile -Scope 6 | Should -Be -ExpectedValue $false

			}

			It 'returns false for a scope of exactly 5' {

				Test-PublicFile -Scope 5 | Should -Be -ExpectedValue $false

			}

		}

	}

}
