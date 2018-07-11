accessing
resolvedVersions
	
	^ ongoingPackageResolutions values collect: [ :each | each packageVersion ]