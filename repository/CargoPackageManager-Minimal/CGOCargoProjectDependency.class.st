"
I represent a dependency to an external Cargo project.

	self example

"
Class {
	#name : #CGOCargoProjectDependency,
	#superclass : #CGOProjectDependencyDeclaration,
	#instVars : [
		'repository',
		'name',
		'constraints',
		'version'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #example }
CGOCargoProjectDependency class >> example [
	^ self named: 'pharo-counter' repositoryUrl: 'github://demarey/pharo-counter:master'
]

{ #category : #'instance creation' }
CGOCargoProjectDependency class >> fromSton: stonReader [
	| repository |
	
	repository := super fromSton: stonReader.
	^ self named: repository name repositoryUrl: repository	repositoryUrl
]

{ #category : #'instance creation' }
CGOCargoProjectDependency class >> named: aName repositoryUrl: gitUrlString [
	
	^ self named: aName repositoryUrl: gitUrlString version: ''
]

{ #category : #'instance creation' }
CGOCargoProjectDependency class >> named: aName repositoryUrl: gitUrlString version: aCommitish [

	^ self new 
		name: aName;
		repository: (CGOGitRepositoryCreator repositoryFromUrl: gitUrlString);
		version: aCommitish;
		yourself
]

{ #category : #'instance-creation' }
CGOCargoProjectDependency class >> named: aName version: aVersion [ 
	
	^ self new
		name: aName;
		constraints: {(CGODependencyConstraint fromString: aVersion)};
		yourself
]

{ #category : #accessing }
CGOCargoProjectDependency >> constraints [

	^ constraints
]

{ #category : #accessing }
CGOCargoProjectDependency >> constraints: someConstraints [ 

	constraints := someConstraints
]

{ #category : #intialization }
CGOCargoProjectDependency >> initializeWithRepository: aCGOGitRepository [ 
	repository := aCGOGitRepository
]

{ #category : #'querying - installed' }
CGOCargoProjectDependency >> isInstalled [
	
	^ project registry isInstalled: self
]

{ #category : #'querying - installed' }
CGOCargoProjectDependency >> isProvidedBy: aInstalledVersion [ 

	^ aInstalledVersion providesProject: self
]

{ #category : #accessing }
CGOCargoProjectDependency >> name [
	^ name
]

{ #category : #accessing }
CGOCargoProjectDependency >> name: aName [ 

	name := aName
]

{ #category : #accessing }
CGOCargoProjectDependency >> repository [
	^ repository
]

{ #category : #accessing }
CGOCargoProjectDependency >> repository: aRepository [ 
	repository := aRepository
]

{ #category : #accessing }
CGOCargoProjectDependency >> repositoryUrl [
	^ repository repositoryUrl
]

{ #category : #solving }
CGOCargoProjectDependency >> resolveInSolver: aCGOSolver [
	
	self isInstalled
		ifTrue: [ ^ project registry projectNamed: self name ].
	
	"If it is not installed, we need to go fetch it from the INTERNET"
	^ repository fetchVersion: version
]

{ #category : #constrains }
CGOCargoProjectDependency >> satisfyConstraints: aSemanticVersion [ 
	^ constraints allSatisfy: [ :each | each isCompatibleWith: aSemanticVersion ]
]

{ #category : #accessing }
CGOCargoProjectDependency >> version: aString [ 
	
	version := aString
]
