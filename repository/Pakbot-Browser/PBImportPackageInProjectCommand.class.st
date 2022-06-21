"
Command to import an existing package as a Pakbot package unit
"
Class {
	#name : #PBImportPackageInProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBImportPackageInProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallLoadProject;
		name: 'Import package';
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #execution }
PBImportPackageInProjectCommand >> execute [

	self project importPackagesNamed: (self packagesToImport collect: #name)
]

{ #category : #interaction }
PBImportPackageInProjectCommand >> packagesToImport [

	| chooser |
	chooser := SpChooserPresenter new
		sourceItems: self project packageCandidates;
		displayBlock: #packageName;
		yourself.
	chooser sourceList applyFilter: self project name.
	^ chooser 
		openModal;
		chosenItems
]