saving
savePackageSourcesToIndexWithMessage: message
	| iceRepository newMcVersion |
	iceRepository := self iceRepository.
	newMcVersion := iceRepository 
		internalSavePackage: (self ensureIcePackageNamed: packageName)
		withMessage: message.
	iceRepository addFilesToIndex: { iceRepository directoryForPackage: newMcVersion package }.
	^ newMcVersion