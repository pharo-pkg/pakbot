versions posting
savePackageVersion: aPackageVersion
	| existingPackageVersion directory |
	existingPackageVersion := self	checkPreviousRegistrationOf: aPackageVersion.
	
	directory := (self rootDirectory / aPackageVersion packageName asLowercase) ensureCreateDirectory.
	(directory / aPackageVersion name asLowercase) writeStreamDo: [ :stream |
		stream nextPutAll: (CGOPackageVersionWriter toStringPretty: aPackageVersion) ].
	self updateVirtualPackagesIndexWith: aPackageVersion.