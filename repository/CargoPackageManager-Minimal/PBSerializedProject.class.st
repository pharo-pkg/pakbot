"
I represent a Pakbot project ready to be serialized.
I map some instance variables to an easily serialized form.
"
Class {
	#name : #PBSerializedProject,
	#superclass : #PBVcsSerializedProject,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #converting }
PBSerializedProject >> asProject [
	"Convert this SerializedProject into a Project.
	All instance variables will be set with values from the SerializableProject"
	| project |
	
	project := self asOngoingProject.
	dict 
		at: #version
		ifAbsent: [ PBError new 
						signal: 'Cannot deserialize a Project with no version defined!' ].
	project version: (dict at: #version) asSemanticVersion.

	dict 
		at: #repositoryUrl
		ifAbsent: [ PBError new 
						signal: 'Cannot deserialize a Project with no source repository defined!' ].
	project repository: (PBSourceRepository fromDictionary: (dict at: #repositoryUrl)).
					
	^ project 
]

{ #category : #initialization }
PBSerializedProject >> initializeWithProject: aPBProjectVersion [
	| resolvedProject |
	self initializeWithPackage: aPBProjectVersion.
	dict at: #version put: aPBProjectVersion version asString.
	resolvedProject := aPBProjectVersion resolve.
	resolvedProject hasConflicts 
		ifTrue: [ PBProjectHasConflictsError signalOnResolution: resolvedProject ].
	self
		addPropertyNamed: #dependencies 
		ifNotEmptyOrNil: ((resolvedProject resolvedDependencies) 
								sorted: [ :first :second | first name < second name ]).
	"used for package dependencies
	self
		addPropertyNamed: #externalProjects 
		ifNotEmptyOrNil: (aPBProject externalProjects)."
	self 
		addPropertyNamed: #units
		ifNotEmptyOrNil: (self sort: aPBProjectVersion packages andCollect: #asSerializedPackage).
	self
		addPropertyNamed: #assemblies 
		ifNotEmptyOrNil: (self sort: aPBProjectVersion assemblies andCollect: #asSerializedPackage).
	self 
		addPropertyNamed: #virtualPackages 
		ifNotEmptyOrNil: (self sort: aPBProjectVersion virtualPackages andCollect: #asSerializedPackage).
	dict
		at: #repositoryUrl
		put: aPBProjectVersion repository asSerializableRepository
]
