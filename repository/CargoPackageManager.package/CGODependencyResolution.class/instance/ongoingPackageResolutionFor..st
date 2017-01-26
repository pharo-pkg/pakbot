private
ongoingPackageResolutionFor: aPackageName
	^ alreadyInstalledPackages
		detect: [ :each | each packageName = aPackageName ]
		ifFound:	[ :packageVersion | self ongoingPackageResolutionForPackageVersion: packageVersion ]
		ifNone: [ ongoingPackageResolutions
				at: aPackageName
				ifAbsentPut: [ CGOOngoingPackageResolution new
						targetedPackage: aPackageName;
						yourself ] ]