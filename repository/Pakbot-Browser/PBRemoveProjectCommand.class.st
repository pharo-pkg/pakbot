"
Command used to remove a project from the registry and optionally remove packages from the system.
"
Class {
	#name : #PBRemoveProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBRemoveProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #remove;
		name: 'Remove project';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #execution }
PBRemoveProjectCommand >> execute [

	self project unload.
]
