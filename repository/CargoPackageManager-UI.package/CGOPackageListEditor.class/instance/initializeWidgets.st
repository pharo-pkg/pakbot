initialization
initializeWidgets
	(label := self newLabel) label: self packageListEditorLabel.
	addButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #addIcon);
		enabled: true;
		help: self addButtonHelpString.
	editButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #editIcon);
		enabled: false;
		help: self editButtonHelpString.
	removeButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #removeIcon);
		enabled: false;
		help: self removeButtonHelpString.
	packageTree := self newFastTable.
	self initializeTable
