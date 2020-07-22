"
I represent a dependency to a project managed by Metacello.
"
Class {
	#name : #PBMetacelloProjectDependency,
	#superclass : #PBProjectDependencyDeclaration,
	#instVars : [
		'url',
		'version'
	],
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #'instance-creation' }
PBMetacelloProjectDependency class >> fromMetacelloSpec: aMetacelloMCBaselineOfProjectSpec [ 
	
	self subclassResponsibility
]

{ #category : #ston }
PBMetacelloProjectDependency class >> fromSton: stonReader [
	| metacelloProject |
	
	metacelloProject := self basicNew.
	stonReader parseMapDo: [ :instVarName :value |
		(instVarName = 'baseline' or: [ instVarName = 'configuration' ])
		 	ifTrue: [ metacelloProject instVarNamed: 'name' put: value ]
		 	ifFalse: [ metacelloProject instVarNamed: instVarName put: value ] ].

	"ensure right types (e.g. url not string"
	^ metacelloProject 
		setName: metacelloProject name 
		repositoryUrl: metacelloProject repositoryUrl
		version: metacelloProject version
]

{ #category : #'instance creation' }
PBMetacelloProjectDependency class >> name: projectName repositoryUrl: repositoryString version: versionString [
	| projectDependency |
	projectDependency := self basicNew.
	projectDependency initialize.
	projectDependency
		setName: projectName
		repositoryUrl: repositoryString
		version: versionString.
	^ projectDependency yourself
]

{ #category : #accessing }
PBMetacelloProjectDependency class >> projectClass [
	self subclassResponsibility 
]

{ #category : #comparing }
PBMetacelloProjectDependency >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	self species = anotherObject species ifFalse: [ ^ false ].
	
	^ self version = anotherObject version and: [ self name = anotherObject name ].
]

{ #category : #conflicts }
PBMetacelloProjectDependency >> additionalConflictingInstalledProjects [

	| metacelloProjectRegistration |
 
	metacelloProjectRegistration := self metacelloProjectRegistry
		registrationForClassNamed: self name
		ifAbsent: [ ^ #() ].
	
	"If the installed version is the same as requested, there is no conflicts"
	self isInstalledInMetacello ifTrue: [ ^ #() ].

	"If the installed version is not the same, we have a conflict"
	metacelloProjectRegistration
		configurationProjectSpecIfPresent: [ :configurationSpec |
			^ {(PBMetacelloConfigurationProjectDependency fromMetacelloSpec: configurationSpec) project: project; yourself} ]
		ifAbsent: [ "" ].		
			
	^ metacelloProjectRegistration
		baselineProjectSpecIfPresent: [ :baselineSpec |
			{(PBMetacelloBaselineProjectDependency fromMetacelloSpec: baselineSpec) project: project; yourself} ]
		ifAbsent: [ #() ].
		

]

{ #category : #accessing }
PBMetacelloProjectDependency >> constraints [

	^ { CGOFixedVersionConstraint with: version }
]

{ #category : #accessing }
PBMetacelloProjectDependency >> dependencies [
	
	"Metacello dependencies are managed as a black box, we don't care"
	^ #()
]

{ #category : #displaying }
PBMetacelloProjectDependency >> displayStringOn: aStream [
	
	aStream
		<< name asString
		<< ' => '
		<< version asString
		<< '('
		<< url asString
		<< ')'
]

{ #category : #testing }
PBMetacelloProjectDependency >> fitsPlatformRequirements [
	
	^ true "it should be managed by Metecello"
]

{ #category : #comparing }
PBMetacelloProjectDependency >> hash [
	^ self name hash
]

{ #category : #'querying - installed' }
PBMetacelloProjectDependency >> isInstalled [
	
	^ super isInstalled or: [ self isInstalledInMetacello ]
]

{ #category : #'querying - installed' }
PBMetacelloProjectDependency >> isInstalledInMetacello [
	self subclassResponsibility 
]

{ #category : #testing }
PBMetacelloProjectDependency >> isMetacelloConfiguration [
	self subclassResponsibility 
]

{ #category : #testing }
PBMetacelloProjectDependency >> isMetacelloProjectDependency [
	^ true
]

{ #category : #accessing }
PBMetacelloProjectDependency >> metacelloProjectRegistry [
	^ project registry metacelloProjectRegistry
]

{ #category : #accessing }
PBMetacelloProjectDependency >> repositoryUrl [
	^ url
]

{ #category : #solving }
PBMetacelloProjectDependency >> resolveInSolver: aCGOSolver [ 
	
	"A metacello configuration project is already solved. It has only a single version and no other constraints, and a single url"
	^ (PBMetacelloProject fromProjectDependency: self)
			registry: project registry
]

{ #category : #initialization }
PBMetacelloProjectDependency >> setName: projectName repositoryUrl: urlOrString version: aVersionString [ 
	name := projectName asSymbol.
	url := urlOrString.
	version := aVersionString.
	
]

{ #category : #ston }
PBMetacelloProjectDependency >> stonOn: stonWriter [
	self subclassResponsibility
]

{ #category : #accessing }
PBMetacelloProjectDependency >> version [
	^ version
]
