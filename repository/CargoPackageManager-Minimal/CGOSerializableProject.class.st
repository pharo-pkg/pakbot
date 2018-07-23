"
I represent a Cargo project ready to be serialized.
I map some instance variables  to an easily serialized form.
"
Class {
	#name : #CGOSerializableProject,
	#superclass : #CGOSerializedArtefact,
	#instVars : [
		'name',
		'repository',
		'unitNames',
		'assemblies',
		'virtualPackages',
		'authors',
		'contributors'
	],
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOSerializableProject class >> from: aCGOProject [
	^ self basicNew
		initializeWithProject: aCGOProject;
		yourself
]

{ #category : #'ston-core' }
CGOSerializableProject class >> stonName [
	^ #CGOPublishedProject
]

{ #category : #deserialization }
CGOSerializableProject >> flushIn: aCGOProject [
	"Flush information from this SerializableProject into the provided CGOProject.
	All instance variables will be set with values from the SerializableProject"
	name isNil
		ifTrue: [ PBError new 
						signal: 'Cannot deserialize a Project with no package or version defined!' ].	
	aCGOProject 
	"name description repository version unitNames assemblies authors"
		instVarNamed: 'name' put: name;
		instVarNamed: 'version' put: (SemanticVersion fromString: version);
		instVarNamed: 'description' put: description;
		instVarNamed: 'repository' put: repository;
		instVarNamed: 'unitNames' put: (self toArray: unitNames);
		instVarNamed: 'assemblies' put: (self toArray: assemblies);
		instVarNamed: 'virtualPackages' put: (self toArray: virtualPackages);
		instVarNamed: 'authors' put: (self toArray: authors);
		yourself.

]

{ #category : #initialization }
CGOSerializableProject >> initializeWithProject: aCGOProject [
	name := aCGOProject packageName.
	description := aCGOProject description.
	repository := aCGOProject repository asSerializableRepository.
	version := aCGOProject version asString.
	unitNames := self toArrayOrNilIfEmpty: aCGOProject packageNames.
	assemblies := self toArrayOrNilIfEmpty: aCGOProject assemblies "asVcsSerializedAssembly?".
	virtualPackages := self toArrayOrNilIfEmpty: (aCGOProject virtualPackages collect: #asVcsSerializedPackageVersion).
	authors := self toArrayOrNilIfEmpty: aCGOProject authors.
]
