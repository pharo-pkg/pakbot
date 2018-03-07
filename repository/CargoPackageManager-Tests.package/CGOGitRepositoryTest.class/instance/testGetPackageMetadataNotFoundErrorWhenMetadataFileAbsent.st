tests
testGetPackageMetadataNotFoundErrorWhenMetadataFileAbsent
	self should: 
		[ (CGOGitRepositoryCreator new
				githubUrl: 'github://demarey/HotelApp:master';
				location: FileLocator temp / ('pharo-tests-' , DateAndTime now asFileNameCompatibleString);
				createAndClone) projectMetadataStonString ]
		raise: Error
		whoseDescriptionIncludes: 'Entry project-metadata.ston is not present in tree a LGitTree (number of entries: 7)'
		description: 'Ensure we get an error when metadata file absent'