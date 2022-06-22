"
Command to remove a part of  a Pakbot project (i.e. a package unit or a package assembly).
It does not actually remove the RPackage associated to a package unit if the later is removed with this command.
"
Class {
	#name : #PBRemovePackageFromProjectCommand,
	#superclass : #PBPackageCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBRemovePackageFromProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #delete;
		name: 'Remove package from project';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBRemovePackageFromProjectCommand >> execute [

	self package project removePackage: self package
]
