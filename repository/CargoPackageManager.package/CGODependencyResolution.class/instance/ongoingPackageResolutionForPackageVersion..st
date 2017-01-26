private
ongoingPackageResolutionForPackageVersion: packageVersion
	^ CGOOngoingPackageResolution new
		packageVersion: packageVersion;
		yourself