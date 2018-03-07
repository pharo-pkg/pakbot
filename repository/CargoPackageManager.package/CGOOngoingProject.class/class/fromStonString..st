instance creation
fromStonString: aStonString
	| vcsSerializedProject |
	vcsSerializedProject := STON fromString: aStonString.
	^ self fromVcsSerializedProject: vcsSerializedProject