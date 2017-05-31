opening
openWithMinimalSpecOn: anOngoingPackageVersion
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec: #minimalSpec