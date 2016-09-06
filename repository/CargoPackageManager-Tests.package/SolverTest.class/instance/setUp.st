running
setUp
	super setUp.
	solver := CGOSolver new
		addRepository: repository;
		yourself.
	Cargo platformAttributes: #(#squeakCommon #pharo #'pharo4.x' #'pharo4.0.x').