registering
register: aPackageVersion
	aPackageVersion registry: self.
	self checkPackageNameRegistrationOf: aPackageVersion packageName.
	installedPackages add: aPackageVersion.
	^ aPackageVersion