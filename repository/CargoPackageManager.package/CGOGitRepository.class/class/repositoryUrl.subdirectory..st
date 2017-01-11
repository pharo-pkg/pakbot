instance creation
repositoryUrl: gitUrlString	subdirectory: directoryName
	^ self basicNew 
		initializeWithRepositoryUrl: gitUrlString	subdirectory: directoryName;
		yourself