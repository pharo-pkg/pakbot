"
I disable the integration of a Pakbot project on an Iceberg repository.
It means that Iceberg will not anymore be able to commit Pakbot metadata.
It allows to use an Iceberg repository having Pakbot metadata as a ""classical"" git repository.

I collaborate with IceProjectReader and IceRepository.
"
Class {
	#name : #PBDisablePakbotProjectCommand,
	#superclass : #IceTipCommand,
	#category : #'CargoPackageManager-Iceberg-Integration'
}

{ #category : #activation }
PBDisablePakbotProjectCommand class >> browserRepositoryListActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: PBIcebergPakbotMenuGroup
		order: 100
		for: IceTipRepositoryListContext
]

{ #category : #testing }
PBDisablePakbotProjectCommand class >> canBeExecutedInContext: aToolContext [
	
	^ aToolContext isRepositoryOperational
		and: [ aToolContext repositoryModel entity project isKindOf: PBIcebergProject ]
]

{ #category : #accessing }
PBDisablePakbotProjectCommand class >> defaultMenuIconName [

	^ #smallCancel
]

{ #category : #accessing }
PBDisablePakbotProjectCommand >> defaultMenuItemName [
	^ 'Disable Packbot project integration'
]

{ #category : #execution }
PBDisablePakbotProjectCommand >> execute [
	| workingCopy iceProject |
	workingCopy := self repositoryModel entity workingCopy.
	iceProject := (IceProjectReader availableReaders
		detect: [ :reader | reader class ~= PBIcebergProjectReader and: [ reader canReadProjectFromCommitish: workingCopy ] ])
			readProjectFromCommitish: workingCopy.
	workingCopy basicSetProject: iceProject
			
]
