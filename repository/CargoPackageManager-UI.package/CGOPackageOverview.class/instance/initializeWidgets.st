initialization
initializeWidgets
	(nameLabel := self newLabel)
		label: 'Name:'.
	self newTextInputField: #nameInputField.
		
	(versionLabel := self newLabel)
		label: 'Version:'.
	self newTextInputField: #versionInputField. 

	"repository"
	(repositoryLabel := self newLabel)
		label: 'Repository:'.
	self newTextInputField: #repositoryInputField. 
		
	(descriptionLabel := self newLabel)
		label: 'Description:'.
	descriptionText := self newText