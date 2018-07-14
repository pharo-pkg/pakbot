Extension { #name : #CGOAbstractPackageDependency }

{ #category : #'*CargoPackageManager-Calypso-Environment' }
CGOAbstractPackageDependency >> managedByCalypsoUsing: aPackageManager [
	^CGOClyPackageDependency "of: (aPackageManager projectOf: self) "on: self
]
