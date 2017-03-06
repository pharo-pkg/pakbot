registering
register: aPackageVersion
	self checkPackageNameRegistrationOf: aPackageVersion packageName.
	installedPackages add: aPackageVersion.
	^ aPackageVersion