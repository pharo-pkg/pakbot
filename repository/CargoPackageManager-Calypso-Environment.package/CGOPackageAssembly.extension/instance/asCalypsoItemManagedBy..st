*CargoPackageManager-Calypso-Environment
asCalypsoItemManagedBy: aPackageManager

	^(CGOClyPackageAssembly of: (aPackageManager projectOf: self) on: self)	
		asCalypsoBrowserItem