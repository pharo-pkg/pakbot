"
Command to add items into a Package Assembly.
"
Class {
	#name : #PBAddPackageToAssemblyCommand,
	#superclass : #PBAssemblyCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBAddPackageToAssemblyCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallAdd;
		name: 'Add Package(s)';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBAddPackageToAssemblyCommand >> execute [
	
	self assembly addPackages: self packagesToAdd
]

{ #category : #interaction }
PBAddPackageToAssemblyCommand >> packagesToAdd [

	| chooser |
	chooser := SpChooserPresenter new
		sourceItems: self assembly packageCandidates;
		displayBlock: #name;
		yourself.
	^ chooser 
		openModal;
		chosenItems
]
