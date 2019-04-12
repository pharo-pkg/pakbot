"
I enable the integration of a Pakbot project on an Iceberg repository.
It means that Iceberg will be able to load and commit Pakbot metadata.

I collaborate with IceProjectReader and IceRepository.
"
Class {
	#name : #PBEnablePakbotProjectCommand,
	#superclass : #IceTipCommand,
	#category : #'CargoPackageManager-Iceberg-Integration'
}

{ #category : #activation }
PBEnablePakbotProjectCommand class >> browserRepositoryListActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: PBIcebergPakbotMenuGroup
		order: 100
		for: IceTipRepositoryListContext
]

{ #category : #testing }
PBEnablePakbotProjectCommand class >> canBeExecutedInContext: aToolContext [
	
	^ aToolContext isRepositoryOperational
		and: [ | workingCopy |
			workingCopy := aToolContext repositoryModel entity workingCopy.
			workingCopy project isPakbotProject not and: [ PBIcebergProjectReader new canReadProjectFromCommitish: workingCopy ] ]
]

{ #category : #accessing }
PBEnablePakbotProjectCommand class >> defaultMenuIconName [

	^ #smallOk
]

{ #category : #accessing }
PBEnablePakbotProjectCommand >> defaultMenuItemName [
	^ 'Enable Packbot project integration'
]

{ #category : #execution }
PBEnablePakbotProjectCommand >> execute [
	| workingCopy |
	workingCopy := self repositoryModel entity workingCopy.
	workingCopy basicSetProject: (IceProjectReader readProjectFrom: workingCopy).
			
]
