"
I am a package repository used to host the meta data of Packbot packages / projects.
I use a file system as backend.

In the repository folder, you will find one folder per (Pakbot) project.
In a project folder, you will get a STON file named <project-name>-<version-number>.ston that contains all the project metadaa for the specified version.
Pakbot will then use this metadatafile to find dependencies and know from where to load this project.
"
Class {
	#name : #PBPackageRepository,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#classVars : [
		'Default'
	],
	#category : #'PakbotPackageManager-Repository'
}

{ #category : #accessing }
PBPackageRepository class >> default [

	^ Default ifNil: [ self newLocalRepositoryIn: FileLocator home / 'dev/rmod/test-pkg-repo' ]
]

{ #category : #accessing }
PBPackageRepository class >> default: aPBPackageRepository [

	Default := aPBPackageRepository.
]

{ #category : #'instance creation' }
PBPackageRepository class >> newLocalRepositoryIn: aFileReference [ 
	^ self new 
		root: aFileReference;
		yourself
]

{ #category : #fetching }
PBPackageRepository >> fetch: aPackageName version: aVersion [
	| file |
	file := self fileForPackageNamed: aPackageName version: aVersion asString.
	file exists 
		ifTrue: [ ^ PBLoadableUnit fromStonString: file contents ]
		ifFalse: [ PBPackageNotFoundError signal ]

]

{ #category : #private }
PBPackageRepository >> fileForPackage: aPackage [
	^ self fileForPackageNamed: aPackage name version: aPackage version asString
]

{ #category : #private }
PBPackageRepository >> fileForPackageNamed: aPackageName version: aVersionString [
	^ root / aPackageName / (aPackageName , '-', aVersionString , '.ston')
]

{ #category : #accessing }
PBPackageRepository >> packages [

	^ root directoryNames reject: [ :each | each beginsWith: '.' ]
]

{ #category : #initializing }
PBPackageRepository >> root: aFileReference [ 
	"The root folder containing the package repository"
	root := aFileReference asFileReference
]

{ #category : #saving }
PBPackageRepository >> saveProject: aPBProjectVersion [ 
	| file fileContent |
	file := self fileForPackage: aPBProjectVersion.
	file exists
		ifTrue: [ PBPublicationError signal: aPBProjectVersion name , ' has already been published'.
				^ self. ].
	aPBProjectVersion isFixedVersion
		ifFalse: [ PBPublicationError signal: aPBProjectVersion name, ' ' , aPBProjectVersion version asString, ' is not a fixed version.'.
			^ self ].
	
	fileContent := String streamContents: [ :stream | 
		stream nextPutAll: (PBPackageVersionWriterV1 toStringPretty: aPBProjectVersion asSerializedPackage) ].
	file parent ensureCreateDirectory.
	file writeStreamDo: [ :stream | stream nextPutAll: fileContent].
]

{ #category : #accessing }
PBPackageRepository >> url [
	
	^ root fullName
]

{ #category : #accessing }
PBPackageRepository >> versionsOf: aPackageName [
	| prefixSize |
	prefixSize := aPackageName size + 1.

	^ [ (root / aPackageName) files
		collect: [ :fileName | fileName basenameWithoutExtension allButFirst: prefixSize ] ]
		on: DirectoryDoesNotExist 
		do: [ PBPackageNotFoundError signal: aPackageName ]
]
