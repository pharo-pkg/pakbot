private
updatePackageVersion: existingPackageVersion with: aPackageVersion
	(voyageRepository list: CGOPackageVersion)
		remove: existingPackageVersion;
		add: aPackageVersion