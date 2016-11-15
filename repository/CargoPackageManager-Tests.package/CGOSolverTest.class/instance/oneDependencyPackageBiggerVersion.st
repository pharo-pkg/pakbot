helpers
oneDependencyPackageBiggerVersion
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'OneDependency';
			add: #version -> '1.0';
			add: #dependencies ->  { #'NoDependencies' -> #('=18') };
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #sourcePackageVersion -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )