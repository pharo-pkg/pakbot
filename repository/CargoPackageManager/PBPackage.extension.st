Extension { #name : #PBPackage }

{ #category : #'*CargoPackageManager' }
PBPackage >> versionLoaded [
	self repository versionLoaded: self name.
]
