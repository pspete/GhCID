# Class definitions loaded into the caller's scope by ScriptsToProcess

class GhCIDItem {
	[string]$Name

	GhCIDItem([string]$Name) {
		$this.Name = $Name
	}
}
