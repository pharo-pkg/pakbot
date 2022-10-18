"
I represent a Pakbot project ready to be serialized.
I map some instance variables to an easily serialized form.
"
Class {
	#name : #PBSerializedProject,
	#superclass : #PBVcsSerializedProject,
	#category : #'Pakbot-Minimal-Serialization'
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
	super initializeWithProject: aPBProjectVersion.

	resolvedProject := aPBProjectVersion resolve.
	resolvedProject hasConflicts 
		ifTrue: [ PBProjectHasConflictsError signalOnResolution: resolvedProject ].

	dict
		at: #repositoryUrl
		put: aPBProjectVersion repository asSerializableRepository
]
