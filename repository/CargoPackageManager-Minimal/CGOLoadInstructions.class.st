"
This object contains the information needed to load the result of a solving.

- groups are an ordered collection of packageStrings to load.
- packageRepositories are the package repositories used for the solving where package versions can be found.
"
Class {
	#name : #CGOLoadInstructions,
	#superclass : #Object,
	#instVars : [
		'groups',
		'packageRepositories'
	],
	#category : 'CargoPackageManager-Minimal-Loader'
}

{ #category : #comparing }
CGOLoadInstructions >> = anotherObject [
	self species = anotherObject species
		ifFalse: [ ^ false ].
		
	^ self groups = anotherObject groups
]

{ #category : #adding }
CGOLoadInstructions >> addGroup: aPackageLoadGroup [
	groups add: aPackageLoadGroup
]

{ #category : #accessing }
CGOLoadInstructions >> cacheRepository [
	^ MCCacheRepository uniqueInstance
]

{ #category : #loading }
CGOLoadInstructions >> fetch [
	self fetchInto: self cacheRepository
]

{ #category : #loading }
CGOLoadInstructions >> fetchInto: aMCRepository [
	groups 
		do: [ :group | group fetchInto: aMCRepository ]
		displayingProgress: [ :group | 'Fetching ' , group name ]
]

{ #category : #accessing }
CGOLoadInstructions >> groups [
	^ groups
]

{ #category : #testing }
CGOLoadInstructions >> includes: aLoadableUnit [
	
	^ groups anySatisfy: [ :group | group includes: aLoadableUnit ]
]

{ #category : #initialization }
CGOLoadInstructions >> initialize [
	super initialize.
	groups := OrderedCollection new.
]

{ #category : #testing }
CGOLoadInstructions >> isEmpty [
	
	^ groups isEmpty
]

{ #category : #loading }
CGOLoadInstructions >> load [
	groups 
		do: [ :group | group load ]
		displayingProgress: [ :group | 'Installing ' , group name ]
]

{ #category : #loading }
CGOLoadInstructions >> mcVersions [
	^ groups collect: #mcVersions
]

{ #category : #serialization }
CGOLoadInstructions >> saveTo: aFileReference [
	aFileReference writeStreamDo: [:stream | stream nextPutAll: self stonString ]
]

{ #category : #loading }
CGOLoadInstructions >> size [

	^ groups size
]

{ #category : #serialization }
CGOLoadInstructions >> stonString [
	self flag: 'TODO: ensure that we only use package references in load instructions and not the full package version'.
	^ (STON toStringPretty: self) withInternetLineEndings
]
