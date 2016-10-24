saving
saveNewVersion: aSemanticVersion
	| repository |
	repository := MCRepository fromUrl: repositoryUrl.
	self workingCopy
		newVersionWithName: (self workingCopy uniqueVersionNameIn: repository)
		message: 'Publication of version ' , aSemanticVersion
		in: repository.
	self flag: 'TODO: update ongoing package version with the new generated package versionString'