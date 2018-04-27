building
create
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			addRemote: self icebergUrl;
			subdirectory: subdirectory;
			location: location";
			To fix: iceRepository".
	^ CGOGitRepository 
		url: self icebergUrl
		repository: iceRepository
		version: version