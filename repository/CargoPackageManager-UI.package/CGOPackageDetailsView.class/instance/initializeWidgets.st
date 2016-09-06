initialization
initializeWidgets
	dependenciesView := CGOPackageDependenciesView newOn: ongoingPackageUnit owner: self.

	(provisionsLabel := self newLabel)
		label: 'Provisions:'.
	self newTextInputField: #provisionsInputField.
	
	(fileLabel := self newLabel)
		label: 'File:'.
	self newTextInputField: #fileInputField.
	
	(platformRequirementsLabel := self newLabel)
		label: 'Platform requirements:'.
	editPlatformRequirementsButton := self newButton
		label: nil;
		icon: (Smalltalk ui icons iconNamed: #editIcon);
		enabled: true;
		help: 'Edit platform requirements'.

