"
I am a package repository used to host the meta data of Packbot packages / projects.
I use a file system as backend.
"
Class {
	#name : #PBPackageRepository,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'PakbotPackageManager-Repository'
}

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
		ifFalse: [ CGOPackageNotFoundError signal ]

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
PBPackageRepository >> saveProject: aPBProject [ 
	| file fileContent |
	file := self fileForPackage: aPBProject.
	file exists
		ifTrue: [ PBPublicationError signal: aPBProject name , ' has already been published'.
				^ self. ].
	aPBProject isFixedVersion
		ifFalse: [ PBPublicationError signal: aPBProject name, ' ' , aPBProject version asString, ' is not a fixed version.'.
			^ self ].
	
	fileContent := String streamContents: [ :stream | 
		stream nextPutAll: (CGOPackageVersionWriterV1 toStringPretty: aPBProject asSerializedPackage) ].
	file parent ensureCreateDirectory.
	file writeStreamDo: [ :stream | stream nextPutAll: fileContent].
]
