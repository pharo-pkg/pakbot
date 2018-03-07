serialization
stonOn: stonWriter
	stonWriter 
		writeObject: self
		streamMap: [ :dictionary | | url |
			url := CGOGitRepositoryCreator urlWithScheme: repositoryUrl.
			dictionary
				at: #repositoryUrl put: url asString;
				at: #version put: version. ]