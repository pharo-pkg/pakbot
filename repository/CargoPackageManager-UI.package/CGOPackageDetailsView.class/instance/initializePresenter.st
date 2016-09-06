initialization
initializePresenter
	super initializePresenter.
	editPlatformRequirementsButton action: [ self editPlatformRequirements ].
	provisionsInputField acceptBlock: [ self updateProvisions ].