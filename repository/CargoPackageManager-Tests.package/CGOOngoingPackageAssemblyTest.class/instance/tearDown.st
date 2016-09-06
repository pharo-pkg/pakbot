running
tearDown
	super tearDown.
	Smalltalk globals
		at: #AssemblyTest
		ifPresent: [ :manifest | manifest removeFromSystem ]