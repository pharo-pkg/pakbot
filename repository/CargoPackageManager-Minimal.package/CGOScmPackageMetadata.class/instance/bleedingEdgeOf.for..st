versions fetching
bleedingEdgeOf: aPackageName for: platformAttributes 
	^ "(self isVirtual: aPackageName)
		ifTrue: [ self bleedingEdgeOfVirtualPackage: aPackageName for: platformAttributes ]
		ifFalse: [" self bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes "]"