saving
savePackageUnit: packageUnit withMessage: commitMessage
	| iceSavedPackage newMcVersion |
	iceSavedPackage := self ensureIcePackageNamed: packageUnit packageName.
	iceSavedPackage repository workingCopy ifNil: [ ^ nil "nothing to save" ].
	newMcVersion := self iceRepository 
		internalSavePackage: iceSavedPackage
		withMessage: commitMessage.
	self iceRepository 
		addFilesToIndex: { self iceRepository directoryForPackage: newMcVersion package }.
	^ newMcVersion