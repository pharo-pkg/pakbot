saving
saveWithMessage: message andMetadataString: stonString
	self savePackageSourcesToIndexWithMessage: message.
	self saveMetadataToIndex: stonString