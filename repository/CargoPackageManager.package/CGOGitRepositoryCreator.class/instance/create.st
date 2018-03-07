building
create
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			remote: (IceRemote url: self icebergUrl);
			subdirectory: subdirectory;
			location: location;
			iceRepository.
	^ CGOGitRepository 
		url: self icebergUrl
		repository: iceRepository
		version: version