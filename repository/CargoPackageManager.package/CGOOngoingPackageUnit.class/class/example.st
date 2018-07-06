example
example
	^ (self for: #UnitTest)
		description: 'A simple ongoing package unit.';
		project: (CGOOngoingProject named: #MyProject);
		yourself