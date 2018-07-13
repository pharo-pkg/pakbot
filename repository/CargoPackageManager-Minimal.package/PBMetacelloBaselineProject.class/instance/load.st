loading
load
	Metacello new 
		repository: repository asString;
		configuration: name;
		version: version;
		load: packageNames.