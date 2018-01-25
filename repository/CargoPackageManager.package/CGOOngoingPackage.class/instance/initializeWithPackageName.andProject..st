initialization
initializeWithPackageName: aPackageName andProject: aCargoProject
	super initialize.
	package := CGOPackageProvider default packageNamed: aPackageName.
	description := ''.
	project := aCargoProject