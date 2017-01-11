saving
saveProjectMetadataToIndex: serializableProject
	^ self iceRepository 
		saveContent: (STON toStringPretty: serializableProject) withInternetLineEndings
		inWorkingCopyFile: self projectMetadataPath