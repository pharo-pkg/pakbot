Extension { #name : #IceMetacelloRepositoryType }

{ #category : #'*Pakbot-Core' }
IceMetacelloRepositoryType >> basicMcRepository [
	^ self mcRepositoryClass location: self location
]

{ #category : #'*Pakbot-Core' }
IceMetacelloRepositoryType class >> httpsUrlFor: aLocationString [
	^ (self for: aLocationString) basicMcRepository httpsUrl 
]
