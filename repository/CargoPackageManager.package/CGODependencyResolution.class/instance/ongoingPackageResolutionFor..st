private
ongoingPackageResolutionFor: aPackageName
	^ ongoingPackageResolutions
		at: aPackageName
		ifAbsentPut: [ CGOResolvedProject new
			targetedPackage: aPackageName;
			yourself ]