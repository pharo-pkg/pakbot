Class {
	#name : #PBCreateProjectDialog,
	#superclass : #ITOptionDialog,
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #examples }
PBCreateProjectDialog class >> example [
	<example>
	self new openDialogWithSpec
]

{ #category : #accessing }
PBCreateProjectDialog >> initialize [
	panels := {
		PBNewProjectPanel new.
		PBImportProjectFromGitPanel new.
		PBImportProjectFromPackageRepository new }.
	super initialize.
	self title: 'Create new Project'.
]
