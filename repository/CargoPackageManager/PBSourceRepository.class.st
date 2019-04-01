"
I'm an abstraction on a Source Code Management system (e.g. git, monticello) where Smalltalk code can be store.
"
Class {
	#name : #PBSourceRepository,
	#superclass : #Object,
	#instVars : [
		'repositoryUrl'
	],
	#category : #'CargoPackageManager-Loading'
}

{ #category : #'instance creation' }
PBSourceRepository class >> classFor: repositoryTypeString [
	^ self subclasses detect: [ :class | class type = repositoryTypeString ]
]

{ #category : #'instance creation' }
PBSourceRepository class >> fromDictionary: aDictionary [ 
	| class |
	class := self classFor: (aDictionary at: #type).
	^ class fromDictionary: aDictionary
]

{ #category : #'instance creation' }
PBSourceRepository class >> fromStringUrl: url subdirectory: subdirectoryName [
	^ (self isGitRepositoryUrl: url)
		ifTrue: [ PBGitRepositoryCreator new
			githubUrl: url;
			subdirectory: subdirectoryName;
			create ]
		ifFalse: [ CGOMonticelloRepository repositoryUrl: url ]
]

{ #category : #testing }
PBSourceRepository class >> isGitRepositoryUrl: aString [
	^ (aString beginsWith: 'git@') 
		or: [ aString endsWith: '.git' ]
]

{ #category : #accessing }
PBSourceRepository class >> type [
	^ self subclassResponsibility
]

{ #category : #converting }
PBSourceRepository >> asSerializableRepository [
	^ self copy
		instVarNamed: 'repositoryUrl' put: repositoryUrl asString;
		yourself 
]

{ #category : #serialization }
PBSourceRepository >> fromSton: stonReader [
	super fromSton: stonReader.
	self isGitRepositoryUrl
		ifFalse: [ repositoryUrl := repositoryUrl asUrl ]
]

{ #category : #serialization }
PBSourceRepository >> isGitRepositoryUrl [
	^ self class isGitRepositoryUrl: repositoryUrl
]

{ #category : #testing }
PBSourceRepository >> isValidRepository [
	
	^ true
]

{ #category : #saving }
PBSourceRepository >> projectMetadataFileName [
	^ 'project-metadata.ston'
]

{ #category : #fetching }
PBSourceRepository >> projectMetadataStonString [
	self subclassResponsibility
]

{ #category : #accessing }
PBSourceRepository >> repositoryUrl [
	^ repositoryUrl
]

{ #category : #saving }
PBSourceRepository >> savePackageUnits: packageUnits	andProjectMetadata: serializableProject	withMessage: commitMessage [
	self subclassResponsibility
]

{ #category : #querying }
PBSourceRepository >> sourcePackageVersionClass [
	self subclassResponsibility
]

{ #category : #serialization }
PBSourceRepository >> stonOn: stonWriter [
	stonWriter writeObject: self asSerializableRepository
]
