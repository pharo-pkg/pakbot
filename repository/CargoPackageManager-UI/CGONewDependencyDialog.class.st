Class {
	#name : #CGONewDependencyDialog,
	#superclass : #ITOptionDialog,
	#category : #'CargoPackageManager-UI'
}

{ #category : #examples }
CGONewDependencyDialog class >> example [
	<example>
	self new openDialogWithSpec
]

{ #category : #accessing }
CGONewDependencyDialog >> initialize [
	panels := {
		CGOMetacelloBaselineDependencyPanel new.
		CGOMetacelloConfigurationDependencyPanel new}.
	super initialize.
	self title: 'Add a dependency'.
]
