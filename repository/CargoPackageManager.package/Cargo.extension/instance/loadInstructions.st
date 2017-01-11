*CargoPackageManager
loadInstructions
	| resolution |
	resolution := CGOSolver new
		repositories: repositories;
		solveDependency: self rootDependency.
	^ CGOLoadInstructionsBuilder new
		resolution: resolution;
		loadInstructions