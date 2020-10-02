Extension { #name : #Association }

{ #category : #'*CargoPackageManager' }
Association >> asPackageDependency [
	^ PBPackageDependency newFrom: self
]
