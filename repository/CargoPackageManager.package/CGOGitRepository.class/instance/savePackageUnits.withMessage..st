saving
savePackageUnits: packageUnits withMessage: commitMessage
	packageUnits 
		do: [ :unit |
				unit sourcePackageVersion 
					saveWithMessage: commitMessage 
					andMetadataString: (self metadataStringFor: unit) ]