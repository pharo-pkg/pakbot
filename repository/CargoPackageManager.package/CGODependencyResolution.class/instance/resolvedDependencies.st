accessing
resolvedDependencies
	^ ongoingPackageResolutions values 
		collect: [ :ongoingPackageResolution | ongoingPackageResolution packageVersion ]