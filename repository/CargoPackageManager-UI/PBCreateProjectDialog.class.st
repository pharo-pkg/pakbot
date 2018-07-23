Class {
	#name : #PBCreateProjectDialog,
	#superclass : #ITOptionDialog,
	#instVars : [
		'acceptCallback',
		'cancelCallback'
	],
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #examples }
PBCreateProjectDialog class >> example [
	<example>
	self new openDialogWithSpec
]

{ #category : #accessing }
PBCreateProjectDialog >> allTypes [
	
	^ { 
	PBNewProjectPanel new.
	PBImportProjectFromGitPanel new }
]

{ #category : #actions }
PBCreateProjectDialog >> doAccept [
	
	acceptCallback cull: self selectedType buildDependency
]

{ #category : #opening }
PBCreateProjectDialog >> openDialogOnAccept: anAcceptCallback onCancel: aCancelCallback [
	
	acceptCallback := anAcceptCallback.
	cancelCallback := aCancelCallback.
	self openDialogWithSpec
]

{ #category : #accessing }
PBCreateProjectDialog >> title [

	^ 'Create new Project'
]
