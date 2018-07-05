running
setUp
	super setUp.
	greaseRepository := GreaseTestResource current cargoLocalRepository.
	greaseRepository savePackageVersion: CGOOngoingProject example asCargoProject. "ensure a project dos not introduce mess in a package repository"
	emptyRepository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	temporaryPath := '/tmp/cargo-repo-test' asFileReference.