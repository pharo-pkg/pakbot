Extension { #name : #IceMetacelloRepositoryType }

{ #category : #'*CargoPackageManager' }
IceMetacelloRepositoryType >> basicMcRepository [
	^ self mcRepositoryClass location: self location
]

{ #category : #'*CargoPackageManager' }
IceMetacelloRepositoryType class >> httpsUrlFor: aLocationString [
	^ (self for: aLocationString) basicMcRepository httpsUrl 
]
