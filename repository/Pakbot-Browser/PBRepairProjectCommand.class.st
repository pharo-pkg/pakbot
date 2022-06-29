"
This command allows to repair a Pakbot project, e.g. solve its dependencies to load the project.
"
Class {
	#name : #PBRepairProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBRepairProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #repair;
		name: 'Repair Project';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #testing }
PBRepairProjectCommand >> canBeExecuted [

	^ super canBeExecuted and: [ self project hasProblems ]
]

{ #category : #executing }
PBRepairProjectCommand >> execute [
	self project ifNil: [ ^ self ].

	(PBProjectRepairPresenter on: self project)
		application: self context application;
		openDialog
]
