saving
saveProjectMetadataToIndex: serializableProject
	^ self iceRepository 
		saveContent: (CGOPackageVersionWriter toStringPretty: serializableProject) withInternetLineEndings
		inWorkingCopyFile: self projectMetadataPath