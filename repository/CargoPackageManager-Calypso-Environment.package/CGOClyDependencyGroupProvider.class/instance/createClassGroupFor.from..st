building groups
createClassGroupFor: aClassQuery from: aClyPackageScope 
	^ClyClassGroup named: 'Dependencies' priority: 0 on: aClassQuery