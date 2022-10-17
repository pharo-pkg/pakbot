"
This trait offers some methods to create temporory files or directories without having to take care of their cleaning at the end of the test.
The trait is useful when you have to subclass a specific class, else, you should use directly `FileTestCase`
"
Trait {
	#name : #TTemporaryFilesTrait,
	#instVars : [
		'directories',
		'files'
	],
	#category : #'Pakbot-Tests-Utils'
}

{ #category : #initialization }
TTemporaryFilesTrait >> initialize [ 
	
	directories := OrderedCollection new.
	files := OrderedCollection new.
]

{ #category : #creating }
TTemporaryFilesTrait >> newMemoryFileSystem [ 
	
	"no need to clean it, it is a memory file system"

	^ FileSystem memory root
]

{ #category : #creating }
TTemporaryFilesTrait >> newTempDirectory [

	^ self newTempDirectoryReference 
		ensureCreateDirectory;
		yourself
]

{ #category : #creating }
TTemporaryFilesTrait >> newTempDirectoryReference [

	| directory |
	
	directory := (FileLocator temp / (self class name,  '-' , UUIDGenerator next asString)) resolve.
	directories add: directory.
	^ directory
]

{ #category : #creating }
TTemporaryFilesTrait >> newTempFile [

	| file |
	
	file := (FileLocator temp / (self class name,  '-' , UUIDGenerator next asString)) resolve.
	files add: file.
	^ file
]

{ #category : #running }
TTemporaryFilesTrait >> tearDown [ 

	directories do: [ :dir | dir ensureDeleteAll ].
	files do: [ :file | file ensureDelete ].
	super tearDown.
]
