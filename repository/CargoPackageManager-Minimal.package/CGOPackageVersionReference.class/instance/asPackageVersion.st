converting
asPackageVersion
	^ self fetchFromCache ifNil: [ self fetchFromRepositories ]