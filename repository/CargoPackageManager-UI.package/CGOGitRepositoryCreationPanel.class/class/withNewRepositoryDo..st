enumerating
withNewRepositoryDo: aBlock
	self new
		onNewRepositoryBlock: aBlock; 
		openWithSpec