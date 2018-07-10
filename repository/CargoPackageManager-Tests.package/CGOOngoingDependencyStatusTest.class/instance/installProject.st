utils
installProject
	
	| newProject |
	newProject := CGOOngoingProject named: 'AnotherProject'.
	registry register: newProject.
	newProject newPackageUnit: #AnotherPackage.