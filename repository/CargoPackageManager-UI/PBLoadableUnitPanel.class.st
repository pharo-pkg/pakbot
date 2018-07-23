"
Common super class for PPM views woth some utility methods
"
Class {
	#name : #PBLoadableUnitPanel,
	#superclass : #ComposablePresenter,
	#category : #'CargoPackageManager-UI'
}

{ #category : #defaults }
PBLoadableUnitPanel class >> labelSize [
	^ 75
]

{ #category : #'building widgets' }
PBLoadableUnitPanel >> newTextInputField: textInputFieldModelName [
	self
		instVarNamed: textInputFieldModelName  
		put: (self newTextInput
			entryCompletion: nil;
			acceptOnCR: true;
			ghostText: 'none')
]
