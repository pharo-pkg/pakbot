accessing
metadata
	^ self iceRepository 
		contentOfFileNamed: self metadataPath
		commit: commitish 