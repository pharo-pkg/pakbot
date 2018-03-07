*CargoPackageManager-Calypso-Environment
asCalypsoItemManagedBy: aPackageManager
	^ (CGOClyVirtualPackage of: (aPackageManager projectOf: self) on: self) asEnvironmentItem