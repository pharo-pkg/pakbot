Class {
	#name : #PBNewProjectPresenterTest,
	#superclass : #PBTest,
	#instVars : [
		'name',
		'url',
		'version',
		'description',
		'editionPanel',
		'newProjectPresenter'
	],
	#category : #'Pakbot-Browser-Tests'
}

{ #category : #running }
PBNewProjectPresenterTest >> setUp [

	super setUp.
	
	newProjectPresenter := PBNewProjectPresenter newApplication: self newApplicationWithRegistry.
	editionPanel := newProjectPresenter projectPanel.
	
	name := 'aName'.
	url := 'git@github.com:pharo-vcs/iceberg.git'.
	version := '1.0.0'.
	description := 'A description'
]

{ #category : #tests }
PBNewProjectPresenterTest >> testProjectIsFilledAfterAccept [

	| project |
	editionPanel name: name.
	editionPanel version: version.
	editionPanel description: description.
	
	project := newProjectPresenter doAccept.
	
	self assert: project name equals: name.
	self assert: project version printString equals: version.
	self assert: project description equals: description.
]

{ #category : #tests }
PBNewProjectPresenterTest >> testProjectIsNotInstalledBeforeAccept [

	editionPanel name: name.
	editionPanel version: version.
	editionPanel description: description.
	
	self assert: registry registeredProjects isEmpty

]

{ #category : #tests }
PBNewProjectPresenterTest >> testProjectIsRegisteredAfterAccept [

	editionPanel name: name.
	editionPanel version: version.
	editionPanel description: description.
	
	newProjectPresenter doAccept.
	
	self 
		shouldnt: [ registry projectNamed: name ]
		raise: PBPackageNotFoundError 
]
