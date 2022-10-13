"
I disable the integration of a Pakbot project on an Iceberg repository.
It means that Iceberg will not anymore be able to commit Pakbot metadata.
It allows to use an Iceberg repository having Pakbot metadata as a ""classical"" git repository.

I collaborate with IceProjectReader and IceRepository.
"
Class {
	#name : #PBDisablePakbotProjectCommand,
	#superclass : #IceTipCommand,
	#category : #'Pakbot-Browser-Iceberg-Integration'
}

{ #category : #accessing }
PBDisablePakbotProjectCommand class >> defaultIconName [

	^ #smallCancel
]

{ #category : #accessing }
PBDisablePakbotProjectCommand class >> defaultName [

	^ 'Disable Packbot project integration'
]

{ #category : #testing }
PBDisablePakbotProjectCommand >> canBeExecuted [
	
	^ self isRepositoryOperational
		and: [ self repositoryModel entity project isKindOf: PBIcebergProject ]
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
