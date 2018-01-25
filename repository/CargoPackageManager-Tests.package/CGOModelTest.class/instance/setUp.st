running
setUp
	super setUp.
	oldRegistry := CGOPackageRegistry default.
	ongoingProject := CGOOngoingProject2 example.
	registry := CGOPackageRegistry new 
		register: ongoingProject;
		register: self unitTestV1;
		register: self unitTestV2;
		yourself.
	CGOPackageRegistry default: registry.