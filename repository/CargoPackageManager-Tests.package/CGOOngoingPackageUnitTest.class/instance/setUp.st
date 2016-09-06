running
setUp
	super setUp.
	ongoingPkg := CGOOngoingPackageUnit on: (TheManifestBuilder new createManifestNamed: 'Test') new