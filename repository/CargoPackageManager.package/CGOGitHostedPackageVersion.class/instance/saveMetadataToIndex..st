saving
saveMetadataToIndex: stonString
	^ self iceRepository 
		saveContent: stonString 
		inWorkingCopyFile: self metadataPath