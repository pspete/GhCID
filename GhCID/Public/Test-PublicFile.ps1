# .ExternalHelp GhCID-help.xml
Function Test-PublicFile {
	[CmdletBinding()]
	Param(
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[Int]
		$Scope
	)
	Process {
		Write-Verbose "Scope: $Scope"
		Test-PrivateFile -TestParam $Scope
	}
} #

