Class {
	#name : #PBNewProjectPresenterTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'panel',
		'name',
		'url',
		'version',
		'description',
		'editionPanel'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBNewProjectPresenterTest >> setUp [

	super setUp.
	
	panel := PBNewProjectPresenter new.
	editionPanel := panel projectPanel.
	project := editionPanel loadableUnit.
	editionPanel registry: testRegistry.
	
	name := 'aName'.
	url := 'git@github.com:pharo-vcs/iceberg.git'.
	version := '1.0.0'.
	description := 'A description'
]

{ #category : #tests }
PBNewProjectPresenterTest >> testProjectIsFilledAfterAccept [

	editionPanel name: name.
	editionPanel version: version.
	editionPanel description: description.
	
	panel accept.
	
	self assert: project name equals: name.
	self assert: project version printString equals: version.
	self assert: project description equals: description.
]

{ #category : #tests }
PBNewProjectPresenterTest >> testProjectIsNotInstalledBeforeAccept [

	editionPanel name: name.
	editionPanel version: version.
	editionPanel description: description.
	
	self deny: (testRegistry isProjectInstalled: project)

]

{ #category : #tests }
PBNewProjectPresenterTest >> testProjectIsRegisteredAfterAccept [

	editionPanel name: name.
	editionPanel version: version.
	editionPanel description: description.
	
	panel accept.
	
	self assert: (testRegistry isProjectInstalled: project)
]
