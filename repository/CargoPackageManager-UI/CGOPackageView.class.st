"
Common super class for PPM views woth some utility methods
"
Class {
	#name : #CGOPackageView,
	#superclass : #ComposablePresenter,
	#category : 'CargoPackageManager-UI'
}

{ #category : #defaults }
CGOPackageView class >> labelSize [
	^ 75
]

{ #category : #'building widgets' }
CGOPackageView >> newTextInputField: textInputFieldModelName [
	self
		instVarNamed: textInputFieldModelName  
		put: (self newTextInput
			entryCompletion: nil;
			acceptOnCR: true;
			ghostText: 'none')
]
