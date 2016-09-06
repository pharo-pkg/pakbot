initialization
initializeWidgets
	(label := self newLabel) 
		label: 'Dependencies:'.
	addButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #addIcon);
		enabled: true;
		help: 'Add a new dependency'.
	editButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #editIcon);
		enabled: false;
		help: 'Edit the dependency'.
	removeButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #removeIcon);
		enabled: false;
		help: 'Rmove the dependency'.
	
	
	dependencyTree := self newTree
		displayBlock: [ :dependency | self displayStringFor: dependency ];
		whenBuiltDo:[ dependencyTree roots: self buildRoots ]