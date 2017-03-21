versions fetching
latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes
	^ (self isVirtual: aPackageName)
		ifTrue: [ self latestVersionOfVirtualPackage: aPackageName suitableForEnvironment: platformAttributes ]
		ifFalse: [ self latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes ]