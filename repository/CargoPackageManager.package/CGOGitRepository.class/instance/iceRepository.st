accessing
iceRepository
	^ IceRepositoryCreator new 
		remote: (IceRemote url: repositoryUrl);
		subdirectory: (subdirectory ifNil: ['']); "Optional, default = '' = code in repository root"
		createRepository.
	" maybe we sould register the repository to Iceberg using #register selector "