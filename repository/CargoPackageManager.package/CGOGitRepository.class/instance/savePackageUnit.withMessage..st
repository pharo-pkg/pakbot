saving
savePackageUnit: packageUnit withMessage: commitMessage
	| newMcVersion |
	newMcVersion := self iceRepository 
		internalSavePackage: (self ensureIcePackageNamed: packageUnit packageName)
		withMessage: commitMessage.
	self iceRepository 
		addFilesToIndex: { self iceRepository directoryForPackage: newMcVersion package }.
	^ newMcVersion