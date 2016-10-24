converting
asPackageVersion
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> self packageName asSymbol;
			add: #version -> self version;
			add: #dependencies -> self rawDependencies;
			add: #provisions -> self provisions;
			add: #description -> self description;
			add: #sourceRepository -> self sourceRepository;
			add: #file -> self file;
			add: #platformRequirements -> self platformRequirements;
			add: #timestamp -> DateAndTime now;
			yourself )