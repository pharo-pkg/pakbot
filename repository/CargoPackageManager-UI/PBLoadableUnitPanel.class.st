"
Common super class for PPM views woth some utility methods
"
Class {
	#name : #PBLoadableUnitPanel,
	#superclass : #ComposablePresenter,
	#category : #'CargoPackageManager-UI'
}

{ #category : #defaults }
PBLoadableUnitPanel class >> isAbstract [

	^ self == PBLoadableUnitPanel
]

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
			ghostText: '')
]

{ #category : #'building widgets' }
PBLoadableUnitPanel >> newTextInputField: textInputFieldModelName description: aDescription [
	self
		instVarNamed: textInputFieldModelName  
		put: (self newTextInput
			entryCompletion: nil;
			acceptOnCR: true;
			ghostText: 'e.g., ', aDescription)
]
