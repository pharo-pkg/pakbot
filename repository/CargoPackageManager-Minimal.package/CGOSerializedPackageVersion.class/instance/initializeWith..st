initialization
initializeWith: aPackageVersion
	package := aPackageVersion packageName.
	version := aPackageVersion version asString.
	description := aPackageVersion description.
	timestamp := aPackageVersion timestamp.