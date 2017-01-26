initialization
initialize
	super initialize.
	ongoingPackageResolutions := Dictionary new.
	alreadyInstalledPackages := Set new.