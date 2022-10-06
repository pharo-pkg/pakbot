"
I represent a dependency to an external Cargo project.

	self example

"
Class {
	#name : #PBPakbotProjectDependency,
	#superclass : #PBProjectDependencyDeclaration,
	#instVars : [
		'repository',
		'constraints'
	],
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #example }
PBPakbotProjectDependency class >> example [
	^ self named: 'pharo-counter' repositoryUrl: 'https://github.com/pharo-pkg/pharo-counter.git' version: 'main'
]

{ #category : #'instance creation' }
PBPakbotProjectDependency class >> fromSton: stonReader [

	| url version projectName |
	stonReader parseMapDo: [ :instVarName :value |
		instVarName = 'project' ifTrue: [ projectName := value ].
		instVarName = 'url' ifTrue: [ url := value ].
		instVarName = 'version' ifTrue: [ version := value ]. ].
	
	^ self named: projectName repositoryUrl: url version: version
]

{ #category : #'instance creation' }
PBPakbotProjectDependency class >> named: aName repositoryUrl: gitUrlString [
	
	^ self named: aName repositoryUrl: gitUrlString version: ''
]

{ #category : #'instance creation' }
PBPakbotProjectDependency class >> named: aName repositoryUrl: gitUrlString version: aCommitish [

	^ self new 
		name: aName;
		repositoryUrl: gitUrlString ;
		version: aCommitish asString
		yourself
]

{ #category : #'instance-creation' }
PBPakbotProjectDependency class >> named: aName version: aVersion [ 
	
	^ self named: aName repositoryUrl: nil version: aVersion
]

{ #category : #'ston-core' }
PBPakbotProjectDependency class >> stonName [

	^ #PakbotProject
]

{ #category : #accessing }
PBPakbotProjectDependency >> constraints [

	^ constraints
]

{ #category : #accessing }
PBPakbotProjectDependency >> constraints: someConstraints [ 

	constraints := someConstraints
]

{ #category : #displaying }
PBPakbotProjectDependency >> displayStringOn: aStream [
	
	aStream
		<< name asString
		<< ' => '
		<< self version asString
		<< '('
		<< self repositoryUrl asString
		<< ')'
]

{ #category : #fetching }
PBPakbotProjectDependency >> fetch [
	^ self fetchFromScm
]

{ #category : #fetching }
PBPakbotProjectDependency >> fetchFromScm [
	repository ifNil: [ PBMissingSourceRepositoryError signal ].

	^ (repository fetchVersion: self version)
		registry: project registry;
		yourself
]

{ #category : #initialization }
PBPakbotProjectDependency >> initializeWithRepository: aCGOGitRepository [ 
	repository := aCGOGitRepository
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
	repository ifNil: [ ^ '' ].
	
	^ repository repositoryUrl
]

{ #category : #accessing }
PBPakbotProjectDependency >> repositoryUrl: aString [ 

	repository := aString isEmptyOrNil 
		ifTrue: [ nil ]
		ifFalse: [PBGitRepositoryCreator repositoryFromUrl: aString].

]

{ #category : #solving }
PBPakbotProjectDependency >> resolvedDependency [
	self isInstalled
		ifTrue: [ ^ project registry projectNamed: self name ].

	"If it is not installed, we need to go fetch it from the INTERNET"
	^ self fetch
]

{ #category : #constraints }
PBPakbotProjectDependency >> satisfyConstraints: aSemanticVersion [ 
	^ constraints allSatisfy: [ :each | each isCompatibleWith: aSemanticVersion ]
]

{ #category : #ston }
PBPakbotProjectDependency >> stonMap [
	| dict |
	
	dict := OrderedDictionary 
		with: #project -> name
		with:	#url -> repository repositoryUrl
		with: 	#version -> self version.
	packagesToLoad ifNotEmpty: [  dict at: #packagesToLoad put: packagesToLoad asArray ].
	^ dict
]

{ #category : #ston }
PBPakbotProjectDependency >> stonOn: stonWriter [

	stonWriter writeMap: self stonMap
]

{ #category : #accessing }
PBPakbotProjectDependency >> version [
	"There is no implementation for more than one constraint"
	constraints size = 0 ifTrue: [ ^ '' ].
	self haltIf: [ constraints size ~= 1 ].

	^ constraints anyOne version asString
]

{ #category : #accessing }
PBPakbotProjectDependency >> version: aString [ 

	aString isEmptyOrNil ifTrue: [ constraints := #(). ^ self].

	constraints := {(CGODependencyConstraint fromVersion: aString)}

]
