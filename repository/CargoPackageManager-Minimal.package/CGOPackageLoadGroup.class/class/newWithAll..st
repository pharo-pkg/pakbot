instance creation
newWithAll: aPackageVersionList
	^ self new 
		intializeWithPackageVersions: aPackageVersionList;
		yourself
		