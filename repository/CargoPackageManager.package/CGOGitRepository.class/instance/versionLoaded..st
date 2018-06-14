notifying
versionLoaded: packageName
	self flag: 'TODO: check if I need to notify Iceberg that a package has been loaded. See IceWorkingCopy>>loadPackagesNamed: aCollection fromCommit: aCommit'
	"iceRepository versionLoaded: 
		(self iceSavedPackageVersionFor: packageName)"