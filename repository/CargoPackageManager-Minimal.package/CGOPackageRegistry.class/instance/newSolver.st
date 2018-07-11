factory
newSolver
	
	^ CGOSolver new
		installedPackages: self installedPackages;
		repositories: { self };
		yourself