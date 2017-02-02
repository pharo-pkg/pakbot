fetching
loadMetadata
	| iceRepository |
	iceRepository := self iceRepository.
	^ [ iceRepository
		contentOfFileNamed: self metadataPath 
		commit: iceRepository headCommit id ]
		on: Error
		do: [ :error | CGOPackageMetadataNotFound signal: error messageText ]