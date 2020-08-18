"
I represent a software project  composed of package units and assemblies.
I hold metadata for the project.
"
Class {
	#name : #CGOProject,
	#superclass : #CGOPackageVersion,
	#instVars : [
		'name',
		'repository',
		'version',
		'units',
		'assemblies',
		'virtualPackages',
		'registry',
		'authors',
		'unitNames'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #example }
CGOProject class >> example [
	^ (self fromOngoing: PBProjectVersion example)
		instVarNamed: 'version' put: '2.1.0' asSemanticVersion;
		yourself
]

{ #category : #'instance creation' }
CGOProject class >> fromOngoing: aCGOOngoingPackage [
	^ self basicNew 
		initializeFromOngoing: aCGOOngoingPackage;
		yourself
]

{ #category : #'instance creation' }
CGOProject class >> fromOngoing: aCGOOngoingPackage project: aCGOProject [
	self shouldNotImplement
]

{ #category : #comparing }
CGOProject >> = other [
	"An ongoingProject and a project with the same name refers to the same entity."
	other species = self species ifFalse: [ ^ false ].
	^ name = other name
]

{ #category : #converting }
CGOProject >> asCargoProject [
	^ self
]

{ #category : #'compatibility - cargo solver' }
CGOProject >> asPackageVersionReference [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ CGOPackageVersionReference 
		packageName: name 
		version: self version asString
]

{ #category : #converting }
CGOProject >> asSerializableCargoProject [
	^ CGOSerializableProject from: self
]

{ #category : #converting }
CGOProject >> asVcsSerializedCargoProject [
	^ PBVcsSerializedProject from: self
]

{ #category : #accessing }
CGOProject >> assemblies [
	^ assemblies
]

{ #category : #accessing }
CGOProject >> authors [
	^ authors
]

{ #category : #'compatibility - cargo solver' }
CGOProject >> dependencies [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ self packageNames collect: #asPackageDependency
]

{ #category : #accessing }
CGOProject >> description [
	^ description
]

{ #category : #'compatibility - cargo solver' }
CGOProject >> fitsPlatformRequirements [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ true
]

{ #category : #'instance creation' }
CGOProject >> fromSton: stonReader [
	"Decode the Cargo serializable project format."
	| serializableProject |
	
	serializableProject := CGOSerializableProject new fromSton: stonReader.
	serializableProject flushIn: self.
]

{ #category : #comparing }
CGOProject >> hash [
	^ name hash
]

{ #category : #'compatibility - cargo solver' }
CGOProject >> isAssembly [
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ true
]

{ #category : #testing }
CGOProject >> isEmpty [
	^ self packageNames isEmpty 
		and: [self assemblies isEmpty 
		and: [self virtualPackages isEmpty ] ]
]

{ #category : #testing }
CGOProject >> isProject [
	^ true
]

{ #category : #accessing }
CGOProject >> name [
	^ name
]

{ #category : #accessing }
CGOProject >> packageName [
	^ name
]

{ #category : #accessing }
CGOProject >> packageNames [
	^ units collect: #packageName
]

{ #category : #accessing }
CGOProject >> packageUnits [
	^ units

]

{ #category : #accessing }
CGOProject >> packages [
	^ self packageUnits , self assemblies, self virtualPackages
]

{ #category : #printing }
CGOProject >> printOn: aStream [
	aStream
		<< self class name
		<< '('
		<< name << '@' << (version asString)
		<< ')'
]

{ #category : #accessing }
CGOProject >> project [
	^ self
]

{ #category : #publishing }
CGOProject >> publish [
	Cargo defaultPackageRepository
		savePackageVersion: self asCargoProject.
]

{ #category : #publishing }
CGOProject >> publishAll [
	self 
		checkVersions;
		publish;
		publishPackageUnits;
		publishPackageAssemblies
]

{ #category : #publishing }
CGOProject >> publishPackageAssemblies [
	self assemblies do: #publish
]

{ #category : #publishing }
CGOProject >> publishPackageUnits [
	self packageUnits do: #publish
]

{ #category : #accessing }
CGOProject >> registry: aCGOPackageRegistry [
	registry := aCGOPackageRegistry
]

{ #category : #accessing }
CGOProject >> repository [
	^ repository
]

{ #category : #accessing }
CGOProject >> version [
	^ version
]

{ #category : #accessing }
CGOProject >> virtualPackages [
	^ virtualPackages
]
