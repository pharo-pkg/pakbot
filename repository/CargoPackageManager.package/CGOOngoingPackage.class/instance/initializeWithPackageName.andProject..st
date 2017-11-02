initialization
initializeWithPackageName: aPackageName andProject: aCargoProjectName
	super initialize.
	package := CGOPackageProvider default packageNamed: aPackageName.
	description := ''.
	projectName := aCargoProjectName