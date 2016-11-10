instance creation
newWithAll: aListOfPackageVersionReferenceStrings
	^ self new 
		intializeWithPackageVersions: aListOfPackageVersionReferenceStrings;
		yourself
		