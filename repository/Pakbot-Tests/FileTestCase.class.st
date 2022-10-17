Class {
	#name : #FileTestCase,
	#superclass : #TestCase,
	#instVars : [
		'directories',
		'files'
	],
	#category : #'Pakbot-Tests-Metacello-Support'
}

{ #category : #initialization }
FileTestCase >> initialize [ 
	
	directories := OrderedCollection new.
	files := OrderedCollection new.
]

{ #category : #creating }
FileTestCase >> newMemoryFileSystem [ 
	
	"no need to clean it, it is a memory file system"

	^ FileSystem memory root
]

{ #category : #creating }
FileTestCase >> newTempDirectory [

	^ self newTempDirectoryReference 
		ensureCreateDirectory;
		yourself
]

{ #category : #creating }
FileTestCase >> newTempDirectoryReference [

	| directory |
	
	directory := (FileLocator temp / (self class name,  '-' , UUIDGenerator next asString)) resolve.
	directories add: directory.
	^ directory
]

{ #category : #creating }
FileTestCase >> newTempFile [

	| file |
	
	file := (FileLocator temp / (self class name,  '-' , UUIDGenerator next asString)) resolve.
	files add: file.
	^ file
]

{ #category : #running }
FileTestCase >> tearDown [ 

	directories do: [ :dir | dir ensureDeleteAll ].
	files do: [ :file | file ensureDelete ].
	super tearDown.
]
