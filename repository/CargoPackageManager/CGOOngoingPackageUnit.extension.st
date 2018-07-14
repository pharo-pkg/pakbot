Extension { #name : #CGOOngoingPackageUnit }

{ #category : #'*CargoPackageManager' }
CGOOngoingPackageUnit >> versionLoaded [
	self repository versionLoaded: self packageName.
]
