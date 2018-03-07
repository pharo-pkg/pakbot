notifying
newRepositoryCreated: anIceRepositoryCreatedAnnouncement
	Iceberg announcer unsubscribe: self.
	onNewRepositoryBlock 
		value: (CGOGitRepositoryCreator repositoryFromIceRepository: anIceRepositoryCreatedAnnouncement repository).
	self delete