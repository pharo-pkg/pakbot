"
I reprensent a Pakbot project. I'm able to serialize and provide changes to the project metadata.
"
Class {
	#name : #PBIcebergProject,
	#superclass : #IceAbstractProject,
	#instVars : [
		'pakbotProject',
		'sourceDirectory'
	],
	#category : #CargoPackageManager
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
	^ self onCommitish: aRepository workingCopy project: aPakbotProject
]

{ #category : #comparing }
PBIcebergProject >> = anotherProject [

	^ super = anotherProject 
		and: [ self contentsString = anotherProject contentsString ]
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
	
	"compute diff between cargo model and saved version?"
	
	self addProjectFileToChangeBuilder: anIceChangeImporter.
]

{ #category : #writing }
PBIcebergProject >> contentsString [

	^ (CGOPackageVersionWriterV1 toStringPretty: pakbotProject asVcsSerializedCargoProject) utf8Encoded
]

{ #category : #initialization }
PBIcebergProject >> initialize [

	super initialize.
	sourceDirectory := 'src'
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

	^ RelativePath with: 'project-metadata.ston'
]

{ #category : #accessing }
PBIcebergProject >> projectFileReference [

	^ commitish fileSystem resolve: self projectFilePath 
]

{ #category : #accessing }
PBIcebergProject >> sourceDirectory [
	^ sourceDirectory
]

{ #category : #accessing }
PBIcebergProject >> sourceDirectory: aString [ 
	sourceDirectory := aString
]
