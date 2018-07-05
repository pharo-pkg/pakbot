running
setUp
	super setUp.
	Cargo platformAttributes: #(#squeakCommon #pharo #'pharo4.x' #'pharo4.0.x').
	resolution := CGOSolver new 
					repositories: { repository };
					solveDependency: seaside31Dependency.
	sorter := CGOLoadInstructionsBuilder new
					resolution: resolution;
					yourself