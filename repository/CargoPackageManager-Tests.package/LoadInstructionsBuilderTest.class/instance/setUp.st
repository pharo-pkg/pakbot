running
setUp
	super setUp.
	loadInstructionsBuilder := CGOLoadInstructionsBuilder new
					resolution: FooDependencyResolutionResource current dependencyResolution;
					yourself