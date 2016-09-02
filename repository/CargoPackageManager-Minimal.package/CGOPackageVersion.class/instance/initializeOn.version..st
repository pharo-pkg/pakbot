initialization
initializeOn: aPackage version: aVersion
	self initializeFrom: {
		#package -> aPackage.
		#version -> aVersion.
	} asDictionary