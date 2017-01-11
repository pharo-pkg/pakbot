instance creation
repository: aCGOSourceRepository packageName: aPackageName
	^ (self classFor: aCGOSourceRepository) basicNew 
		repository: aCGOSourceRepository packageName: aPackageName;
		yourself