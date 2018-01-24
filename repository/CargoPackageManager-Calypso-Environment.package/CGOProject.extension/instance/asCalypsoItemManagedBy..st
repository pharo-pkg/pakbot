*CargoPackageManager-Calypso-Environment
asCalypsoItemManagedBy: aPackageManager 
	| calypsoProject |
	calypsoProject := aPackageManager projectOf: self.
	^ClyBrowserItem named: self name with: calypsoProject