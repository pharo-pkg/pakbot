actions
installFromFile: aFileReference
	self installFrom: (STON fromStream: aFileReference readStream)