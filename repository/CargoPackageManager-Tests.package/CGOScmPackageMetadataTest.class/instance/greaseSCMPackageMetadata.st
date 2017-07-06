test data
greaseSCMPackageMetadata
	^ CGOScmPackageMetadata new
		registerProjectFromSourceRepository: self greaseRepository;
		yourself