instance creation
named: aString inProject: aProject

	^ self basicNew
		initializeWithPackageName: aString andProject: aProject;
		yourself 
		