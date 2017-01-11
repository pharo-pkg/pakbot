saving
saveAndCommitWithMessage: message andMetadataString: stonString
	self saveWithMessage: message andMetadataString: stonString.
	^ self iceRepository 
		commitIndexWithMessage: message
		andParents: { self iceRepository headCommit }