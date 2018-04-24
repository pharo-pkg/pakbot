testing
isEmpty
	^ self packageUnitNames isEmpty 
		and: [self assemblies isEmpty 
		and: [self virtualPackages isEmpty ] ]