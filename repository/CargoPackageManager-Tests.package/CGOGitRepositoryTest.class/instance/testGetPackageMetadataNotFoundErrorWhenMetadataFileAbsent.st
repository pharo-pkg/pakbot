tests
testGetPackageMetadataNotFoundErrorWhenMetadataFileAbsent

	repository := CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/HotelApp:master';
		location: self iceRepositoryLocation;
		createAndClone.

	self should: [ repository projectMetadataStonString ] raise: FileDoesNotExistException