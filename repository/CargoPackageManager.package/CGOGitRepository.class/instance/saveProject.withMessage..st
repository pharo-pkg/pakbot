saving
saveProject: aVcsSerializedCargoProject withMessage: commitMessage
	self saveProjectMetadataToIndex: aVcsSerializedCargoProject.
	^ self iceRepository commitWithMessage: commitMessage
	