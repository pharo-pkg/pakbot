projects
newProjectNamed: aString 
	
	| project |
	project := CGOOngoingProject named: aString.
	self register: project.
	^ project