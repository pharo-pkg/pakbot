Extension { #name : #Association }

{ #category : #'*CargoPackageManager' }
Association >> asPackageDependency [
	^ CGOPackageDependency newFrom: self
]
