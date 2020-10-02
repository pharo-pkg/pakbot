Extension { #name : #PBAbstractPackageDependency }

{ #category : #'*CargoPackageManager-Calypso-Environment' }
PBAbstractPackageDependency >> managedByCalypsoUsing: aPackageManager [
	^CGOClyPackageDependency "of: (aPackageManager projectOf: self) "on: self
]
