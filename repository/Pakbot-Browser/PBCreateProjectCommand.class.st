"
A command to create a new (empty) Pakbot project
"
Class {
	#name : #PBCreateProjectCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'projectName'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #executing }
PBCreateProjectCommand >> execute [
	
	PBCreateProjectDialog new
		openDialogOnAccept: [ :selectedType | PBProjectCreated announceOnProject: selectedType accept ]
		onCancel: [ "Nothing" ]
]
