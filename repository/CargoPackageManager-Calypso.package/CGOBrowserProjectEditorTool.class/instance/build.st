initialization
build
	| project |
	project := context lastSelectedProject.
	self addMorph: project name asMorph fullFrame: LayoutFrame identity