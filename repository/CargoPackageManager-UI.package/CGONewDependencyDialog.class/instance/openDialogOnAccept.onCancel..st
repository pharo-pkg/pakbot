opening
openDialogOnAccept: anAcceptCallback onCancel: aCancelCallback
	
	acceptCallback := anAcceptCallback.
	cancelCallback := aCancelCallback.
	self openDialogWithSpec