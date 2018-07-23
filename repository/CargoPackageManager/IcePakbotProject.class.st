"
I reprensent a Pakbot project. I'm able to serialize and provide changes to the project metadata.
"
Class {
	#name : #IcePakbotProject,
	#superclass : #IceAbstractProject,
	#instVars : [
		'pakbotProject',
		'sourceDirectory'
	],
	#category : #CargoPackageManager
}

{ #category : #'instance creation' }
IcePakbotProject class >> onCommitish: aCommitish project: aPakbotProject [ 
	^ self new
		commitish: aCommitish;
		pakbotProject: aPakbotProject;
		yourself 
]

{ #category : #'instance creation' }
IcePakbotProject class >> onRepository: aRepository project: aPakbotProject [ 
	^ self onCommitish: aRepository workingCopy project: aPakbotProject
]

{ #category : #comparing }
IcePakbotProject >> = anotherProject [

	^ super = anotherProject 
		and: [ self contentsString = anotherProject contentsString ]
]

{ #category : #changes }
IcePakbotProject >> addProjectFileToChangeBuilder: anIceChangeImporter [ 

	anIceChangeImporter
		addFileNamed: self projectFilePath basename
		path: self projectFilePath
		contents: self contentsString.
]

{ #category : #changes }
IcePakbotProject >> addToChangeBuilder: anIceChangeImporter [ 
	
	"compute diff between cargo model and saved version?"
	
	self addProjectFileToChangeBuilder: anIceChangeImporter.
]

{ #category : #writing }
IcePakbotProject >> contentsString [

	^ (CGOPackageVersionWriterV1 toStringPretty: pakbotProject asVcsSerializedCargoProject) utf8Encoded
]

{ #category : #accessing }
IcePakbotProject >> pakbotProject [
	^ pakbotProject
]

{ #category : #accessing }
IcePakbotProject >> pakbotProject: aPakbotProject [ 
	pakbotProject := aPakbotProject
]

{ #category : #accessing }
IcePakbotProject >> projectFilePath [

	^ RelativePath with: 'project-metadata.ston'
]

{ #category : #accessing }
IcePakbotProject >> projectFileReference [

	^ commitish fileSystem resolve: self projectFilePath 
]

{ #category : #accessing }
IcePakbotProject >> sourceDirectory [
	^ sourceDirectory
]

{ #category : #accessing }
IcePakbotProject >> sourceDirectory: aString [ 
	sourceDirectory := aString
]
