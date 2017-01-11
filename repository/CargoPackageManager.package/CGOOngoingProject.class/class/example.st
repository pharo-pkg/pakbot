example
example
	^ (CGOOngoingProject for: #'MyProject')
		version: '0.1-dev';
		description: 'A simple project used for illustration.';
		repository: CGOGitRepository example;
		packageUnitNames: #('Package1' 'Package2');
		yourself