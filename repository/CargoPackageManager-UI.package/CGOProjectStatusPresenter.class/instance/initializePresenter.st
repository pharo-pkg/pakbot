initialization
initializePresenter
	
	SystemAnnouncer uniqueInstance weak
		when: CGOProjectAnnouncement
		send: #handleAnnouncement:
		to: self.
		
	actionButton action: [ (CGOOpenRepairDialog onProject: project) execute ]