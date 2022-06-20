"
Command to create a new (empty) assembly into a project
"
Class {
	#name : #PBCreateAssemblyCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBCreateAssemblyCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #newerPackagesAvailable;
		name: 'New Assembly';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #execution }
PBCreateAssemblyCommand >> execute [
	| assemblyName |
	assemblyName := self application newRequest
		title: 'New assembly name';
		text: self project name, '-';
		openModal.
	assemblyName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	self project addAssemblyNamed: assemblyName.
]
