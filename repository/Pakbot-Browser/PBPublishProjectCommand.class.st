"
A command to publish a project and all its packages to a package repository. 
It will publish to the default Pakbot package repository.
"
Class {
	#name : #PBPublishProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBPublishProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #publish;
		name: 'Publish project';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBPublishProjectCommand >> execute [

	project publish
]
