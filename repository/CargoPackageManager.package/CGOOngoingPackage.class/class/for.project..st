instance creation
for: aPackageName project: aCargoProject
	^ self basicNew
		initializeWithPackageName: aPackageName andProject: aCargoProject;
		yourself 