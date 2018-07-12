initialization
initializeWithPackageName: aPackageName andProject: aCargoProject
	self initialize.
	package := CGOPackageProvider default packageNamed: aPackageName.
	description := ''.
	project := aCargoProject