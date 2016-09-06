private
updatePackageVersion: existingPackageVersion with: aPackageVersion
	voyageRepository cache
		at: (voyageRepository idOf: existingPackageVersion)
		put: aPackageVersion.
	aPackageVersion update.