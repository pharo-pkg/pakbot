private
addPackageResolutionFor: aPackageName
	^ ongoingPackageResolutions
			at: aPackageName
			put: (CGOOngoingPackageResolution new
				targetedPackage: aPackageName;
				yourself)