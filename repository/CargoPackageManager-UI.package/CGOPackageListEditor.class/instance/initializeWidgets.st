initialization
initializeWidgets
	(label := self newLabel) label: self packageListEditorLabel.
	addButton := self newButton
		label: nil;
		icon: (self iconNamed: #addIcon);
		enabled: true;
		help: self addButtonHelpString.
	editButton := self newButton
		label: nil;
		icon: (self iconNamed: #editIcon);
		enabled: false;
		help: self editButtonHelpString.
	removeButton := self newButton
		label: nil;
		icon: (self iconNamed: #removeIcon);
		enabled: false;
		help: self removeButtonHelpString.
	packageTree := self newFastTable.
	self initializeTable
