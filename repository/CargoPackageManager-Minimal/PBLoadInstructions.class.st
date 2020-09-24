"
This object contains the information needed to load the result of a solving.

- groups are an ordered collection of packageStrings to load.
- packageRepositories are the package repositories used for the solving where package versions can be found.
"
Class {
	#name : #PBLoadInstructions,
	#superclass : #Object,
	#instVars : [
		'groups',
		'packageRepositories'
	],
	#category : #'CargoPackageManager-Minimal-Loader'
}

{ #category : #comparing }
PBLoadInstructions >> = anotherObject [
	self species = anotherObject species
		ifFalse: [ ^ false ].
		
	^ self groups = anotherObject groups
]

{ #category : #adding }
PBLoadInstructions >> addGroup: aPackageLoadGroup [
	groups add: aPackageLoadGroup
]

{ #category : #testing }
PBLoadInstructions >> anySatisfy: aBlock [
	
	^ groups anySatisfy: [ :group | group anySatisfy: aBlock ] 
]

{ #category : #accessing }
PBLoadInstructions >> cacheRepository [
	^ MCCacheRepository uniqueInstance
]

{ #category : #loading }
PBLoadInstructions >> fetch [
	self fetchInto: self cacheRepository
]

{ #category : #loading }
PBLoadInstructions >> fetchInto: aMCRepository [
	groups 
		do: [ :group | group fetchInto: aMCRepository ]
		displayingProgress: [ :group | 'Fetching ' , group name ]
]

{ #category : #accessing }
PBLoadInstructions >> groups [
	^ groups
]

{ #category : #testing }
PBLoadInstructions >> includes: aLoadableUnit [
	
	^ groups anySatisfy: [ :group | group includes: aLoadableUnit ]
]

{ #category : #initialization }
PBLoadInstructions >> initialize [
	super initialize.
	groups := OrderedCollection new.
]

{ #category : #testing }
PBLoadInstructions >> isEmpty [
	
	^ groups isEmpty
]

{ #category : #loading }
PBLoadInstructions >> load [
	groups 
		do: [ :group | group load ]
		displayingProgress: [ :group | 'Installing ' , group name ]
]

{ #category : #loading }
PBLoadInstructions >> mcVersions [
	^ groups collect: #mcVersions
]

{ #category : #serialization }
PBLoadInstructions >> saveTo: aFileReference [
	aFileReference writeStreamDo: [:stream | stream nextPutAll: self stonString ]
]

{ #category : #loading }
PBLoadInstructions >> size [

	^ groups size
]

{ #category : #serialization }
PBLoadInstructions >> stonString [
	self flag: 'TODO: ensure that we only use package references in load instructions and not the full package version'.
	^ (STON toStringPretty: self) withInternetLineEndings
]
