Extension { #name : #CGOOngoingPackage }

{ #category : #'*CargoPackageManager' }
CGOOngoingPackage >> versionLoaded [
	self repository versionLoaded: self packageName.
]
