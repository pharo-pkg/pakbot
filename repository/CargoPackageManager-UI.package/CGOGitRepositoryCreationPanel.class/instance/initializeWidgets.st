initialization
initializeWidgets
	newRepositoryButton := self newButton
		label: 'New repository';
		icon: (Smalltalk ui icons iconNamed: #smallNew);
		enabled: true.
	cloneRepositoryButton := self newButton
		label: 'Clone repository';
		icon: (Smalltalk ui icons iconNamed: #add);
		enabled: true.
	addLocalRepositoryButton := self newButton
		label: 'Add local repository';
		icon: (Smalltalk ui icons iconNamed: #packageAdd);
		enabled: true.
