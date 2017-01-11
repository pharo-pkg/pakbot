saving
savePackageUnits: packageUnits	andProjectMetadata: serializableProject	withMessage: commitMessage
	| parents |
	self savePackageUnits: packageUnits withMessage: commitMessage.
	self saveProjectMetadataToIndex: serializableProject.
	parents := [ { self iceRepository headCommit } ] 
		on: LGit_GIT_EUNBORNBRANCH
		do: [ #() ].
	^ self iceRepository 
		commitIndexWithMessage: commitMessage
		andParents: parents