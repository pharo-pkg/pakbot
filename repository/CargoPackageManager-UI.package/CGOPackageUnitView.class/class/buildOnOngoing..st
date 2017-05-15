private
buildOnOngoing: anOngoingPackageVersion
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		buildWithSpec