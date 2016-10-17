helpers
noDependenciesPackage
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'NoDependencies';
			add: #version -> '17';
			add: #dependencies -> #();
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #repositories -> #();
			add: #file -> '';
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )