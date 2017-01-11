loading
projectMetadataStonString
	| repository |
	repository := self iceRepository.
	^ repository
		contentOfFileNamed: self projectMetadataPath 
		commit: repository headCommit id