Class {
	#name : #PBNewProjectPanelTest,
	#superclass : #CGOAbstractTest,
	#instVars : [
		'registry',
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
PBNewProjectPanelTest >> setUp [

	super setUp.
	registry := CGOPackageRegistry new.
	
	panel := PBNewProjectPanel new.
	editionPanel := panel projectPanel.
	project := editionPanel loadableUnit.
	editionPanel registry: registry.
	
	name := 'aName'.
	url := 'git@github.com:pharo-vcs/iceberg.git'.
	version := '1.0.0'.
	description := 'A description'
]

{ #category : #tests }
PBNewProjectPanelTest >> testProjectIsFilledAfterAccept [

	editionPanel nameInputField text: name.
	editionPanel versionInputField text: version.
	editionPanel descriptionText text: description.
	
	panel accept.
	
	self assert: project name equals: name.
	self assert: project version equals: version.
	self assert: project description equals: description.
]

{ #category : #tests }
PBNewProjectPanelTest >> testProjectIsNotInstalledBeforeAccept [

	editionPanel nameInputField text: name.
	editionPanel versionInputField text: version.
	editionPanel descriptionText text: description.
	
	self deny: (registry isProjectInstalled: project)

]

{ #category : #tests }
PBNewProjectPanelTest >> testProjectIsRegisteredAfterAccept [

	editionPanel nameInputField text: name.
	editionPanel versionInputField text: version.
	editionPanel descriptionText text: description.
	
	panel accept.
	
	self assert: (registry isProjectInstalled: project)
]
