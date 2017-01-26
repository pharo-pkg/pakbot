*CargoPackageManager
loadInstructions
	| resolution |
	resolution := CGOSolver new
		repositories: repositories;
		installedPackages: self installedPackages;
		solveDependency: self rootDependency.
	^ CGOLoadInstructionsBuilder new
		resolution: resolution;
		loadInstructions