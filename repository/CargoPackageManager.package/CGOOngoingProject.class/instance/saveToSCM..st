saving
saveToSCM: commitMessage
	self repository
		savePackageUnits: self modifiedPackageUnits
		andProjectMetadata: self asCargoProject asSerializableCargoProject
		withMessage: commitMessage