instance creation
for: aPackageName project: aCargoProjectName
	^ self basicNew
		initializeWithPackageName: aPackageName andProject: aCargoProjectName;
		yourself 