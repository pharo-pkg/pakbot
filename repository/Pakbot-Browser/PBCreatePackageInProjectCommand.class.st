"
Command used to create a new (empty) Pakbot package unit
"
Class {
	#name : #PBCreatePackageInProjectCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'usePakbot',
		'unitName'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBCreatePackageInProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallAdd;
		name: 'New package';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBCreatePackageInProjectCommand >> execute [
	unitName := self application newRequest
		title: 'New package name';
		text: self project name, '-';
		openModal.
		
	unitName isEmptyOrNil ifTrue: [ ^ self ].
	
	self project createPackageNamed: unitName.
]
