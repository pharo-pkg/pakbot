"
Command to remove a package from an assembly.
The package will still be present in the project.
"
Class {
	#name : #PBRemovePackageReferenceFromAssemblyCommand,
	#superclass : #PBPackageCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBRemovePackageReferenceFromAssemblyCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #delete;
		name: 'Remove package from assembly';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBRemovePackageReferenceFromAssemblyCommand >> execute [

	self packageRefUIItem removeFromAssembly
]

{ #category : #accessing }
PBRemovePackageReferenceFromAssemblyCommand >> packageRefUIItem [

	^ context selectedItem
]
