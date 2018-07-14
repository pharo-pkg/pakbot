Class {
	#name : #CGONewDependencyDialog,
	#superclass : #ITOptionDialog,
	#instVars : [
		'acceptCallback',
		'cancelCallback'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #examples }
CGONewDependencyDialog class >> example [
	<example>
	self new openDialogWithSpec
]

{ #category : #accessing }
CGONewDependencyDialog >> allTypes [
	
	^ { 
	CGOMetacelloBaselineDependencyPanel new.
	CGOMetacelloConfigurationDependencyPanel new }
]

{ #category : #actions }
CGONewDependencyDialog >> doAccept [
	
	acceptCallback cull: self selectedType buildDependency
]

{ #category : #opening }
CGONewDependencyDialog >> openDialogOnAccept: anAcceptCallback onCancel: aCancelCallback [
	
	acceptCallback := anAcceptCallback.
	cancelCallback := aCancelCallback.
	self openDialogWithSpec
]

{ #category : #accessing }
CGONewDependencyDialog >> title [

	^ 'Add a dependency'
]
