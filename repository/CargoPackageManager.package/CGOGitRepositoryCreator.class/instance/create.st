building
create
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			addRemote: url asString;
			subdirectory: subdirectory;
			location: location";
			To fix: iceRepository".
	^ CGOGitRepository 
		url: self icebergUrl
		repository: iceRepository
		version: version