versions fetching
latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes 
	^ "(self isVirtual: aPackageName)
		ifTrue: [ self bleedingEdgeOfVirtualPackage: aPackageName for: platformAttributes ]
		ifFalse: [" self latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes "]"