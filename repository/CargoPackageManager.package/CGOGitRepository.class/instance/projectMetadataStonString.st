fetching
projectMetadataStonString
	| repository |
	self ensureCloned.
	repository := self iceRepository.
	^ repository
		contentOfFileNamed: self projectMetadataPath 
		commit: repository headCommit id