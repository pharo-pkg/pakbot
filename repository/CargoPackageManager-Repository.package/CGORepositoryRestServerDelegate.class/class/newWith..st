instance creation
newWith: aPackageRepository
	^ self basicNew 
		initializeWithRepository: aPackageRepository