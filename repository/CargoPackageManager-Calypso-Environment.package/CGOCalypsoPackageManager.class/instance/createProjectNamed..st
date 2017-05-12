operations
createProjectNamed: aString
	| project |
	project := CGOOngoingProject for: aString asSymbol.
	cargoRegistry register: project