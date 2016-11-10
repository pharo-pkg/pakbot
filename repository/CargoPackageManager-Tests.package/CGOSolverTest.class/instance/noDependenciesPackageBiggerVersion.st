helpers
noDependenciesPackageBiggerVersion
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'NoDependencies';
			add: #version -> '18';
			add: #dependencies -> #();
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #src -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )