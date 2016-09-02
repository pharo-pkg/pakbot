*CargoPackageManager
loadInstructions
	| resolution |
	resolution := CGOSolver new
		addRepository: Cargo defaultPackageRepository;
		solveDependency: self rootDependency.
	^ CGOLoadInstructionsBuilder new
		resolution: resolution;
		loadInstructions