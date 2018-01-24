*CargoPackageManager-Calypso-Environment
asCalypsoItemManagedBy: aPackageManager
	| calypsoPackage |
	calypsoPackage := aPackageManager packageOf: self.
	^ClyBrowserItem named: self packageName with: calypsoPackage