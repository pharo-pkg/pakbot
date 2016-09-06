initialization
initializePresenter
	nameInputField acceptBlock: [ self updateName ].
	versionInputField acceptBlock: [ self updateVersion ].
	repositoryEditButton action: 
		[ ongoingPackageVersion setSourceRepositories.
		self refreshWidgetValues ].
	descriptionText whenTextIsAccepted: 
		[ :newText | self updateDescriptionWith: newText asString ]