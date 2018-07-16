"
I represent a Cargo project ready to be serialized on a Version Control System (e.g. git).
I map some instance variables  to an easily serialized form.
"
Class {
	#name : #CGOVcsSerializedProject,
	#superclass : #CGOVcsSerializedPackage,
	#instVars : [
		'units',
		'assemblies',
		'virtualPackages',
		'externalProjects'
	],
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOVcsSerializedProject class >> from: aCGOOngoingProject [
	^ self basicNew
		initializeWithOngoing: aCGOOngoingProject;
		yourself
]

{ #category : #'ston-core' }
CGOVcsSerializedProject class >> stonAllInstVarNames [
	"Override to encode my instances using a custom set of instance variables or to define their order."
	| instVarNames |
	instVarNames := #(#name #description #externalProjects #units #assemblies #virtualPackages).
	self 
		assert: instVarNames size = self allInstVarNames size
		description: 'Error: some instance variable will not be serialized!'.
	^ instVarNames
]

{ #category : #'ston-core' }
CGOVcsSerializedProject class >> stonName [
	^ #OngoingProject
]

{ #category : #converting }
CGOVcsSerializedProject >> asOngoingPackage [
	^ CGOOngoingProject fromVcsSerializedProject: self
]

{ #category : #deserialization }
CGOVcsSerializedProject >> flushIn: aCGOOngoingProject [
	"Flush information from this VcsSerializedProject into the provided CGOProject.
	All instance variables will be set with values from the SerializableProject"
	name isNil
		ifTrue: [ CGOPackageManagerError new 
						signal: 'Cannot deserialize a Project with no package defined!' ].	
	aCGOOngoingProject 
		initializeWithPackageName: name andProject: nil;
		description: description;
		packageUnits: ((self toArray: units) collect: #asOngoingPackage as: Set);
		assemblies: ((self toArray: assemblies) collect: #asOngoingPackage as: Set);
		virtualPackages: ((self toArray: virtualPackages) collect: #asOngoingPackage as: Set);
		externalProjects: (self toDictionary: externalProjects).
		
	aCGOOngoingProject packages do: [:package | package project: aCGOOngoingProject ]
]

{ #category : #initialization }
CGOVcsSerializedProject >> initializeWithOngoing: aCGOOngoingProject [
	super initializeWithOngoing: aCGOOngoingProject.
	units := self toArrayOrNilIfEmpty: (aCGOOngoingProject packageUnits collect: #asVcsSerializedPackageUnit).
	assemblies := self toArrayOrNilIfEmpty: (aCGOOngoingProject assemblies collect: #asVcsSerializedPackageAssembly).
	virtualPackages := self toArrayOrNilIfEmpty: (aCGOOngoingProject virtualPackages collect: #asVcsSerializablePackageVersion).
	externalProjects := self toArrayOrNilIfEmpty: (aCGOOngoingProject externalProjects)

]

{ #category : #accessing }
CGOVcsSerializedProject >> packageUnits [
	^ units
]
