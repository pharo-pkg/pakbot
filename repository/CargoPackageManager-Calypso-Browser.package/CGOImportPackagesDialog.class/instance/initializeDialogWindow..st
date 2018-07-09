initialization
initializeDialogWindow: aWindow
	acceptButton := aWindow toolbar okButton.
	cancelButton := aWindow toolbar cancelButton.
	acceptButton
		disable;
		label: 'Add'