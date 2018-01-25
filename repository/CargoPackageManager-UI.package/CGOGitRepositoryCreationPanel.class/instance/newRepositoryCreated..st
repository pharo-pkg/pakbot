notifying
newRepositoryCreated: anIceRepositoryCreatedAnnouncement
	Iceberg announcer unsubscribe: self.
	onNewRepositoryBlock 
		value: (CGOGitRepository repository: anIceRepositoryCreatedAnnouncement repository).
	self delete