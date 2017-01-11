running
setUp
	super setUp.
	solver := CGOSolver new
		repositories: { repository };
		yourself.
	Cargo platformAttributes: #(#squeakCommon #pharo #'pharo4.x' #'pharo4.0.x').