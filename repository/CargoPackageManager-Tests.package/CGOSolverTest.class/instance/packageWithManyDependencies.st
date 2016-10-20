helpers
packageWithManyDependencies
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'ManyDependencies';
			add: #version -> '1.0';
			add: #dependencies ->  { #'OneDependency' -> #('=1.0.0') . #'NoDependencies' -> #('=17') };
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #repositories -> #();
			add: #file -> '';
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )