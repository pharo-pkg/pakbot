Class {
	#name : #PBNewDependencyDialog,
	#superclass : #ITOptionDialog,
	#category : #'Pakbot-Browser-Presenters-Dependencies'
}

{ #category : #examples }
PBNewDependencyDialog class >> example [
	<example>
	self new openDialogWithSpec
]

{ #category : #accessing }
PBNewDependencyDialog >> initialize [
	panels := {
		PBMetacelloBaselineDependencyPresenter new.
		PBMetacelloConfigurationDependencyPanel new.
		PBPakbotDependencyPanel new}.
	super initialize.
	self title: 'Add a dependency'.
	
	panels do: [ :aPanel | aPanel whenChangedDo: [ :p | self okEnabled: p isValid  ]]
]

{ #category : #private }
PBNewDependencyDialog >> replacePanelWith: aType [

	super replacePanelWith: aType.
	self okEnabled: aType isValid
]
