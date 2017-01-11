initialization
initializeWithPackageName: aPackageName andProject: aCargoProjectName
	super initialize.
	package := CGOPackageProvider default packageNamed: aPackageName.
	version := '0.1-dev' asSemanticVersion.
	description := ''.
	timestamp := DateAndTime now.
	projectName := aCargoProjectName