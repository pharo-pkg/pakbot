initialization
initializeWidgets
	(nameLabel := self newLabel)
		label: 'Name:'.
	self newTextInputField: #nameInputField.
	browseButton := self newButton
		icon: (Smalltalk ui icons glamorousBrowse);
		action: [ ongoingPackageVersion manifest browse ];
		help: 'Browse Manifest'.
		
	(versionLabel := self newLabel)
		label: 'Version:'.
	self newTextInputField: #versionInputField. 

	"repository"
	(repositoryLabel := self newLabel)
		label: 'Repository:'.
	repositoryValueLabel := self newLabel.
	repositoryEditButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #monticelloPackageIcon);
		help: 'Add a new repository to this project';
		yourself.
		
	(descriptionLabel := self newLabel)
		label: 'Description:'.
	descriptionText := self newText