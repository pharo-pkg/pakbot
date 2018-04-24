example
example
	^ (self fromOngoing: CGOOngoingProject example)
		instVarNamed: 'version' put: '2.1.0' asSemanticVersion;
		yourself