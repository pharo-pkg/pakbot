signaling
signalDependencyConflictWith: aPolicy
	| error |
	
	error := CGODependencyConflictError new.
	error
		policy1: self;
		policy2: aPolicy; 
		signal