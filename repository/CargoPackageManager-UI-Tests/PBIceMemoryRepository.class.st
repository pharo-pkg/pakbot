"
An extension of IceMemoryRepository to test Pakbot repositories withour having to clone code.
"
Class {
	#name : #PBIceMemoryRepository,
	#superclass : #IceMemoryRepository,
	#instVars : [
		'location',
		'fs'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #accessing }
PBIceMemoryRepository >> fileSystem [
	^ fs
]

{ #category : #initialization }
PBIceMemoryRepository >> initialize [
	fs := FileSystem memory.
]

{ #category : #testing }
PBIceMemoryRepository >> isCodeMissing [
	^ self subdirectory isEmptyOrNil 
		ifTrue: [ self isMissing ]
		ifFalse: [ (self repositoryDirectory / self subdirectory) exists not  ]
]

{ #category : #testing }
PBIceMemoryRepository >> isMissing [
	^ self repositoryDirectory isNil 
		or: [ self repositoryDirectory exists not ]
]

{ #category : #testing }
PBIceMemoryRepository >> isValidRepository [
	^ true
]

{ #category : #'as yet unclassified' }
PBIceMemoryRepository >> location [
	^ location
]

{ #category : #accessing }
PBIceMemoryRepository >> location: aPathString [ 
	location := fs referenceTo: aPathString.
]

{ #category : #'API-project' }
PBIceMemoryRepository >> project [
	^ self workingCopy project
]

{ #category : #accessing }
PBIceMemoryRepository >> remotes [
	^ #()
]

{ #category : #accessing }
PBIceMemoryRepository >> repositoryDirectory [
	^ location
]
