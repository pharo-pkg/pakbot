registering
register: aPackageVersion
	aPackageVersion registry: self.
	self checkPackageNameRegistrationOf: aPackageVersion packageName.
	installedPackages add: aPackageVersion.
	self registerProject: aPackageVersion project.
	^ aPackageVersion