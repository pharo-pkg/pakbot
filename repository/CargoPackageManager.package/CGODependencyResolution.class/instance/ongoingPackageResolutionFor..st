private
ongoingPackageResolutionFor: aPackageName
	^ ongoingPackageResolutions
		at: aPackageName
		ifAbsentPut: [ CGOOngoingPackageResolution new
			targetedPackage: aPackageName;
			yourself ]