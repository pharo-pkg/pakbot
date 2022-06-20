"
I present different options to create a project:
- new project
- import from a source code repository
- import from a package version
"
Class {
	#name : #PBAddProjectPresenter,
	#superclass : #SpOptionListPresenter,
	#category : #'Pakbot-Browser-Presenters-NewProject'
}

{ #category : #examples }
PBAddProjectPresenter class >> example [
	self new openDialog.
]

{ #category : #initialization }
PBAddProjectPresenter >> allOptions [

	^ { PBNewProjectPresenter .
		PBImportProjectFromGitPresenter .
		PBImportProjectFromPackageRepositoryPresenter }
		collect: [ :class | class newApplication: self application ]
]

{ #category : #initialization }
PBAddProjectPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Create new Project';
		initialExtent: 800@500
]
