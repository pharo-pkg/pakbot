adding
registerProjectFromSourceRepository: aCGOSourceRepository at: projectId
	^ self 
		registerProject: (CGOOngoingProject fromRepository: aCGOSourceRepository)
		at: projectId