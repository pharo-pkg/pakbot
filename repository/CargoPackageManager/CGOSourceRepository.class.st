"
I'm an abstraction on a Source Code Management system (e.g. git, monticello) where Smalltalk code can be store.
"
Class {
	#name : #CGOSourceRepository,
	#superclass : #Object,
	#instVars : [
		'repositoryUrl'
	],
	#category : 'CargoPackageManager-Loading'
}

{ #category : #'instance creation' }
CGOSourceRepository class >> fromStringUrl: url subdirectory: subdirectoryName [
	^ (self isGitRepositoryUrl: url)
		ifTrue: [ CGOGitRepositoryCreator new
			githubUrl: url;
			subdirectory: subdirectoryName;
			create ]
		ifFalse: [ CGOMonticelloRepository repositoryUrl: url ]
]

{ #category : #testing }
CGOSourceRepository class >> isGitRepositoryUrl: aString [
	^ (aString beginsWith: 'git@') 
		or: [ aString endsWith: '.git' ]
]

{ #category : #converting }
CGOSourceRepository >> asSerializableRepository [
	^ self copy
		instVarNamed: 'repositoryUrl' put: repositoryUrl asString;
		yourself 
]

{ #category : #serialization }
CGOSourceRepository >> fromSton: stonReader [
	super fromSton: stonReader.
	self isGitRepositoryUrl
		ifFalse: [ repositoryUrl := repositoryUrl asUrl ]
]

{ #category : #serialization }
CGOSourceRepository >> isGitRepositoryUrl [
	^ self class isGitRepositoryUrl: repositoryUrl
]

{ #category : #testing }
CGOSourceRepository >> isValidRepository [
	
	^ true
]

{ #category : #saving }
CGOSourceRepository >> projectMetadataFileName [
	^ 'project-metadata.ston'
]

{ #category : #fetching }
CGOSourceRepository >> projectMetadataStonString [
	self subclassResponsibility
]

{ #category : #accessing }
CGOSourceRepository >> repositoryUrl [
	^ repositoryUrl
]

{ #category : #saving }
CGOSourceRepository >> savePackageUnits: packageUnits	andProjectMetadata: serializableProject	withMessage: commitMessage [
	self subclassResponsibility
]

{ #category : #querying }
CGOSourceRepository >> sourcePackageVersionClass [
	self subclassResponsibility
]

{ #category : #serialization }
CGOSourceRepository >> stonOn: stonWriter [
	stonWriter writeObject: self asSerializableRepository
]
