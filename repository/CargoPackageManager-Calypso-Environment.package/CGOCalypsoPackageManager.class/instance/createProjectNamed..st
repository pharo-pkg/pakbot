operations
createProjectNamed: aString
	| project |
	project := CGOOngoingProject named: aString asSymbol.
	cargoRegistry register: project