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

{ #category : #accessing }
PBEnablePakbotProjectCommand class >> defaultIconName [
	
	^ #smallOk
]

{ #category : #accessing }
PBEnablePakbotProjectCommand class >> defaultName [
	^ 'Enable Packbot project integration'
]

{ #category : #testing }
PBEnablePakbotProjectCommand >> canBeExecuted [

	^ self isRepositoryOperational
		and: [ | workingCopy |
			workingCopy := self repositoryModel entity workingCopy.
			workingCopy project isPakbotProject not and: [ PBIcebergProjectReader new canReadProjectFromCommitish: workingCopy ] ]
]

{ #category : #execution }
PBEnablePakbotProjectCommand >> execute [
	| workingCopy |
	workingCopy := self repositoryModel entity workingCopy.
	workingCopy basicSetProject: (IceProjectReader readProjectFrom: workingCopy).
			
]
