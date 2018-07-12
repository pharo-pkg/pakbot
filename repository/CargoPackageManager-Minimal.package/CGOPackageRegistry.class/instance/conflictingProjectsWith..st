conflicting
conflictingProjectsWith: aCGOResolvedDependency

	| cargoProjectConflicts metacelloProjectRegistration |
	cargoProjectConflicts := self registeredProjects select: [ :each | each isConflictingWith: aCGOResolvedDependency ].
	
	metacelloProjectRegistration := MetacelloProjectRegistration registry
		registrationForClassNamed: aCGOResolvedDependency name
		ifAbsent: [ ^ cargoProjectConflicts ].
	
	metacelloProjectRegistration
		baselineProjectSpecIfPresent: [ :baselineSpec |
			1halt: 'not yet implemented'.
			cargoProjectConflicts add: baselineSpec ]
		ifAbsent: [ "Nothing" ].
		
	metacelloProjectRegistration
		configurationProjectSpecIfPresent: [ :configurationSpec |
			cargoProjectConflicts add: (CGOMetacelloConfigurationProject fromMetacelloSpec: configurationSpec) ]
		ifAbsent: [ "Nothing" ].
	
	^ cargoProjectConflicts