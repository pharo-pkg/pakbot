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

{ #category : #initialization }
PBCreateProjectDialog >> initialize [
	panels := {
		PBNewProjectPresenter new.
		PBImportProjectFromGitPanel new.
		PBImportProjectFromPackageRepositoryPanel new }.
	super initialize.
	self title: 'Create new Project'.
]
