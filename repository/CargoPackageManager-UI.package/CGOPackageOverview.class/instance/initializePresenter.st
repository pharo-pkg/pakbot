initialization
initializePresenter
	nameInputField acceptBlock: [ self error: 'Project name should not change' ].
	versionInputField acceptBlock: [ self updateVersion ].
	repositoryInputField acceptBlock: [ self updateRepository ].
	descriptionText whenTextIsAccepted: 
		[ :newText | self updateDescription ]