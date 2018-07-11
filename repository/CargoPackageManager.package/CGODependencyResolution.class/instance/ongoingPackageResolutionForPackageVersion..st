private
ongoingPackageResolutionForPackageVersion: packageVersion
	^ CGOResolvedProject new
		resolvedProjectVersion: packageVersion;
		yourself