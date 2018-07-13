*CargoPackageManager
loadInstructions
	| resolution |
	resolution := CGOSolver new
		repositories: repositories;
		solveProject: self rootDependency.
	^ CGOLoadInstructionsBuilder new
		resolution: resolution;
		loadInstructions