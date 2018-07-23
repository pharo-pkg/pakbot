Class {
	#name : #CGOClyPackageDependencies,
	#superclass : #ClyTypedQuery,
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #'items type' }
CGOClyPackageDependencies class >> resultItemsType [
	^RPackage 
]

{ #category : #execution }
CGOClyPackageDependencies >> buildResult: aQueryResult [

	| dependencies |
	dependencies := OrderedCollection new.
	
	scope packagesDo: [ :each | 
		each dependencies do: [ :dependency |
			each add: (dependency managedByCalypsoUsing: each manager)]].
	
	aQueryResult fillWith: dependencies
]

{ #category : #execution }
CGOClyPackageDependencies >> checkEmptyResult [
	
	scope packagesDo: [ :each | 
		each dependencies do: [ :dependency | ^false]].
	^true
	
]

{ #category : #execution }
CGOClyPackageDependencies >> collectMetadataOf: aQueryResult by: anEnvironmentPlugin [

	self flag: #todo
]

{ #category : #testing }
CGOClyPackageDependencies >> isEmpty [
	^ true
]

{ #category : #'system changes' }
CGOClyPackageDependencies >> isResult: aQueryResult affectedBy: aSystemAnnouncement [
	self flag: #todo.
	^false
]

{ #category : #testing }
CGOClyPackageDependencies >> retrievesItemsOfType: itemTypeClass [
	1halt.
	^itemTypeClass = RPackage or: [itemTypeClass = ClyManagedProject]
]
