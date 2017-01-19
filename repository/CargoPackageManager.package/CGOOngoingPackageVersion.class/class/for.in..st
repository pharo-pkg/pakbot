instance creation
for: aPackageName in: aCargoProjectName
	^ self basicNew
		initializeWithPackageName: aPackageName andProject: aCargoProjectName;
		yourself 