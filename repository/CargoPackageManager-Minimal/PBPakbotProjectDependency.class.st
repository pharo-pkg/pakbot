"
I represent a dependency to an external Cargo project.

	self example

"
Class {
	#name : #PBPakbotProjectDependency,
	#superclass : #PBProjectDependencyDeclaration,
	#instVars : [
		'repository',
		'name',
		'constraints',
		'version'
	],
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #example }
PBPakbotProjectDependency class >> example [
	^ self named: 'pharo-counter' repositoryUrl: 'git@github.com:demarey/pharo-counter.git'
]

{ #category : #'instance creation' }
PBPakbotProjectDependency class >> fromSton: stonReader [
	| repository |
	
	repository := super fromSton: stonReader.
	^ self named: repository name repositoryUrl: repository	repositoryUrl
]

{ #category : #accessing }
PBPakbotProjectDependency class >> iconName [
	^ #remote
]

{ #category : #'instance creation' }
PBPakbotProjectDependency class >> named: aName repositoryUrl: gitUrlString [
	
	^ self named: aName repositoryUrl: gitUrlString version: ''
]

{ #category : #'instance creation' }
PBPakbotProjectDependency class >> named: aName repositoryUrl: gitUrlString version: aCommitish [

	^ self new 
		name: aName;
		repository: (CGOGitRepositoryCreator repositoryFromUrl: gitUrlString);
		version: aCommitish;
		yourself
]

{ #category : #'instance-creation' }
PBPakbotProjectDependency class >> named: aName version: aVersion [ 
	
	^ self new
		name: aName;
		constraints: {(CGODependencyConstraint fromString: aVersion)};
		yourself
]

{ #category : #accessing }
PBPakbotProjectDependency >> constraints [

	^ constraints
]

{ #category : #accessing }
PBPakbotProjectDependency >> constraints: someConstraints [ 

	constraints := someConstraints
]

{ #category : #intialization }
PBPakbotProjectDependency >> initializeWithRepository: aCGOGitRepository [ 
	repository := aCGOGitRepository
]

{ #category : #accessing }
PBPakbotProjectDependency >> name [
	^ name
]

{ #category : #accessing }
PBPakbotProjectDependency >> name: aName [ 

	name := aName
]

{ #category : #accessing }
PBPakbotProjectDependency >> repository [
	^ repository
]

{ #category : #accessing }
PBPakbotProjectDependency >> repository: aRepository [ 
	repository := aRepository
]

{ #category : #accessing }
PBPakbotProjectDependency >> repositoryUrl [
	^ repository repositoryUrl
]

{ #category : #solving }
PBPakbotProjectDependency >> resolveInSolver: aCGOSolver [
	
	self isInstalled
		ifTrue: [ ^ project registry projectNamed: self name ].
	
	"If it is not installed, we need to go fetch it from the INTERNET"
	^ (repository fetchVersion: version)
			registry: project registry;
			yourself
]

{ #category : #constrains }
PBPakbotProjectDependency >> satisfyConstraints: aSemanticVersion [ 
	^ constraints allSatisfy: [ :each | each isCompatibleWith: aSemanticVersion ]
]

{ #category : #ston }
PBPakbotProjectDependency >> stonOn: stonWriter [
	stonWriter writeMap: (OrderedDictionary 
		with: 	#name -> name
		with:	#repository -> repository
		with: 	#version -> version) 

]

{ #category : #accessing }
PBPakbotProjectDependency >> version: aString [ 
	
	version := aString
]
