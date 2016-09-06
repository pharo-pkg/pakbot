running
tearDown
	super tearDown.
	Smalltalk globals
		at: #ManifestTest
		ifPresent: [ :manifest | manifest removeFromSystem ]