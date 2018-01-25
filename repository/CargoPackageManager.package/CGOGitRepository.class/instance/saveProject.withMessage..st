saving
saveProject: aVcsSerializedCargoProject withMessage: commitMessage
	| parents |
	self savePackageUnits: aVcsSerializedCargoProject packageUnits withMessage: commitMessage.
	self saveProjectMetadataToIndex: aVcsSerializedCargoProject.
	parents := [ { self iceRepository headCommit } ] 
		on: LGit_GIT_EUNBORNBRANCH
		do: [ #() ].
	^ self iceRepository 
		commitIndexWithMessage: commitMessage
		andParents: parents