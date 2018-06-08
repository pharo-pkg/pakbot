fetching
projectMetadataStonString
	self ensureCloned.
	
	^ (iceRepository headCommit fileSystem / self projectMetadataPath) contents