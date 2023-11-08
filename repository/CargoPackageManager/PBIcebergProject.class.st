"
I reprensent a Pakbot project. I'm able to serialize and provide changes to the project metadata.
I keep a reference to non-pakbot project for compatibility purposes.
"
Class {
	#name : #PBIcebergProject,
	#superclass : #IceAbstractProject,
	#instVars : [
		'pakbotProject',
		'sourceDirectory',
		'nonPakbotProject'
	],
	#category : #'CargoPackageManager-Iceberg-Integration'
}

{ #category : #'instance creation' }
PBIcebergProject class >> onCommitish: aCommitish project: aPakbotProject [ 
	^ self new
		commitish: aCommitish;
		pakbotProject: aPakbotProject;
		yourself 
]

{ #category : #'instance creation' }
PBIcebergProject class >> onRepository: aRepository project: aPakbotProject [ 
	^ (self onCommitish: aRepository workingCopy project: aPakbotProject)
			nonPakbotProject: aRepository project;
			yourself.
]

{ #category : #comparing }
PBIcebergProject >> = anotherProject [

	^ super = anotherProject 
		and: [ self contentsString = anotherProject contentsString ]
]

{ #category : #changes }
PBIcebergProject >> addIcebergProjectFileToChangeBuilder: anIceChangeImporter [ 
	
	nonPakbotProject ifNil: [ ^ self ].
	
	nonPakbotProject addProjectFileToChangeBuilder: anIceChangeImporter 
]

{ #category : #changes }
PBIcebergProject >> addProjectFileToChangeBuilder: anIceChangeImporter [ 

	anIceChangeImporter
		addFileNamed: self projectFilePath basename
		path: self projectFilePath
		contents: self contentsString.
]

{ #category : #changes }
PBIcebergProject >> addToChangeBuilder: anIceChangeImporter [ 
	
	"compute diff between pakbot model and saved version?"
	
	self addProjectFileToChangeBuilder: anIceChangeImporter.
	self addIcebergProjectFileToChangeBuilder: anIceChangeImporter.
]

{ #category : #writing }
PBIcebergProject >> contentsString [

	^ (PBPackageVersionWriterV1 toStringPretty: pakbotProject asVcsSerializedCargoProject) withInternetLineEndings utf8Encoded
]

{ #category : #initialization }
PBIcebergProject >> initialize [

	super initialize.
	sourceDirectory := ''
]

{ #category : #testing }
PBIcebergProject >> isPakbotProject [
	^ true
]

{ #category : #accessing }
PBIcebergProject >> name [
	
	^ pakbotProject name
]

{ #category : #accessing }
PBIcebergProject >> nonPakbotProject: anIceProject [ 
	anIceProject isPakbotProject ifTrue: [ ^ self ].
	
	nonPakbotProject := anIceProject
]

{ #category : #accessing }
PBIcebergProject >> pakbotProject [
	^ pakbotProject
]

{ #category : #accessing }
PBIcebergProject >> pakbotProject: aPakbotProject [ 
	pakbotProject := aPakbotProject
]

{ #category : #accessing }
PBIcebergProject >> projectFilePath [
	^ nonPakbotProject 
		ifNil: [ RelativePath with: 'project-metadata.ston' ]
		ifNotNil: [ RelativePath withAll: { nonPakbotProject sourceDirectory . 'project-metadata.ston' } ]
]

{ #category : #accessing }
PBIcebergProject >> projectFileReference [
	"We need the iceberg basic project to know the path of Pharo sources in the repository.
	Maybe sourceDirectory should be handled directly by Pakbot metadata in the future?"
	(IceBasicProjectReader new canReadProjectFromCommitish: commitish)
		ifTrue: [ nonPakbotProject := IceBasicProjectReader new readProjectFromCommitish: commitish ].

	^ commitish fileSystem resolve: self projectFilePath 
]

{ #category : #accessing }
PBIcebergProject >> sourceDirectory [
	^ nonPakbotProject sourceDirectory
]

{ #category : #accessing }
PBIcebergProject >> sourceDirectory: aString [ 
	sourceDirectory := aString
]
