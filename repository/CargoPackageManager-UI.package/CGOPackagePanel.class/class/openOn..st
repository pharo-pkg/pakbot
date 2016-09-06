instance creation
openOn: aRPackageOrPackageName
	^ self openOnOngoing: (self ongoingPackageVersionFor: aRPackageOrPackageName)