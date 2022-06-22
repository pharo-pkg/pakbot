"
Remove the assembly from the project
"
Class {
	#name : #PBDeleteAssemblyCommand,
	#superclass : #PBAssemblyCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBDeleteAssemblyCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #delete;
		name: 'Remove Assembly';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBDeleteAssemblyCommand >> execute [

	assembly remove
]
