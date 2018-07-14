Extension { #name : #CGOPackage }

{ #category : #'*CargoPackageManager-RepositoryBackend' }
CGOPackage class >> isVoyageRoot [
	^ true
]

{ #category : #'*CargoPackageManager-RepositoryBackend' }
CGOPackage class >> voyageCollectionName [
	^ 'Package'
]
