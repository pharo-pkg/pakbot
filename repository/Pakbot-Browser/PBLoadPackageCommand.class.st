"
Command to load a package defined as a Pakbot package unit.

It will load the package from its repository and register it in the registry. 
"
Class {
	#name : #PBLoadPackageCommand,
	#superclass : #PBPackageCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBLoadPackageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #glamorousUp;
		name: 'Load Package';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBLoadPackageCommand >> execute [

	self package load
]
