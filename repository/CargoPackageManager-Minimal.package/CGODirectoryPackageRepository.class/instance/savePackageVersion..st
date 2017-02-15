versions posting
savePackageVersion: aPackageVersion
	| existingPackageVersion directory |
	existingPackageVersion := self checkPreviousRegistrationOf: aPackageVersion.
	directory := (self directoryFor: aPackageVersion) ensureCreateDirectory.
	directory / aPackageVersion name asLowercase
		writeStreamDo: [ :stream | 
			stream nextPutAll: (CGOPackageVersionWriter toStringPretty: aPackageVersion) ].
	self updateVirtualPackagesIndexWith: aPackageVersion