running
setUp
	super setUp.
	sorter := CGOLoadInstructionsBuilder new
					resolution: FooDependencyResolutionResource current dependencyResolution;
					yourself