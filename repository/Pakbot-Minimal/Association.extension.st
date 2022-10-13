Extension { #name : #Association }

{ #category : #'*Pakbot-Minimal' }
Association >> asPackageDependency [
	^ PBPackageDependency newFrom: self
]
