tests
testGetPackageMetadataNotFoundErrorWhenMetadataFileAbsent
	self should: 
		[ (CGOGitRepositoryCreator new
				githubUrl: 'github://demarey/HotelApp:master';
				location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
				createAndClone) projectMetadataStonString ]
		raise: FileDoesNotExistException