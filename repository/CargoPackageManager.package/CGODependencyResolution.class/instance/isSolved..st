testing
isSolved: aPackageName
	^ alreadyInstalledPackages
		detect: [ :each | each packageName = aPackageName ]
		ifFound: [ true ]
		ifNone: [ (self ongoingPackageResolutionFor: aPackageName) isSolved ]