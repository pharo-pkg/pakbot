private
ongoingPackageResolutionForPackageVersion: packageVersion
	^ CGOResolvedProject new
		packageVersion: packageVersion;
		yourself