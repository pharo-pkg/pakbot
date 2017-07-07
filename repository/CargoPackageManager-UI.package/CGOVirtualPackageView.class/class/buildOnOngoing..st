private
buildOnOngoing: anOngoingVirtualPackageVersion
	^ self basicNew
		initializeWith: anOngoingVirtualPackageVersion;
		buildWithSpec