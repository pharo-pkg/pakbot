initialization
initializePresenter
	nameInputField acceptBlock: [ self updateName ].
	versionInputField acceptBlock: [ self updateVersion ].
	descriptionText whenTextIsAccepted: 
		[ :newText | self updateDescriptionWith: newText asString ]