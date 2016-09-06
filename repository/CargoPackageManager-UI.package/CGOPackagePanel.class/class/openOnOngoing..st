private
openOnOngoing: anOngoingPackageVersion
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		openWithSpec;
		yourself