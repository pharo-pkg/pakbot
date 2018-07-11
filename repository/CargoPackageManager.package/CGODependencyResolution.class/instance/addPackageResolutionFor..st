private
addPackageResolutionFor: aPackageName
	^ ongoingPackageResolutions
			at: aPackageName
			put: (CGOResolvedProject new
				targetedPackage: aPackageName;
				yourself)