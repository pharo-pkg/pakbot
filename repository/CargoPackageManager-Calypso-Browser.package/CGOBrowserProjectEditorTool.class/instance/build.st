initialization
build
	| managedProject |
	managedProject := context lastSelectedProject.
	self 
		addMorph: (CGOProjectPanel buildOnOngoing: managedProject project asOngoingProject)
		fullFrame: LayoutFrame identity