saving
saveNewVersion: aSemanticVersion
	| mcRepository |
	mcRepository := repository mcRepository.
	self workingCopy
		newVersionWithName: (self workingCopy uniqueVersionNameIn: mcRepository)
		message: 'Publication of version ' , aSemanticVersion
		in: mcRepository.
	self flag: 'TODO: update ongoing package version with the new generated package versionString'