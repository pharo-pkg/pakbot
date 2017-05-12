*CargoPackageManager-Calypso-Environment
asCalypsoItemManagedBy: aPackageManager
	| item calypsoProject |
	calypsoProject := aPackageManager projectOf: self.
	item := ClyEnvironmentItem named: self name with: calypsoProject.
	item scope: ClyProjectScope.
	^ item