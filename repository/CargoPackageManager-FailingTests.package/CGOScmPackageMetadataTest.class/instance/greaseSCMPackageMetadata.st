test data
greaseSCMPackageMetadata
	^ CGOScmPackageMetadata new
		registerProjectFromSourceRepository: self greaseRepository at: #Grease;
		yourself