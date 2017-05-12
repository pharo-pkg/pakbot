*CargoPackageManager-Calypso-Environment
asCalypsoItemManagedBy: aPackageManager
	| item calypsoPackage |
	calypsoPackage := aPackageManager packageOf: self.
	item := ClyEnvironmentItem named: self packageName with: calypsoPackage.
	item scope: ClyPackageScope.
	^ item