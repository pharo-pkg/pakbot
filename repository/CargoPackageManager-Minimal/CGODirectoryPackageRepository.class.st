"
This kind of repository is meant to be used as a local repository in the current machine. Useful for caches or testing.

Create an instance of myself doing:

  CGODirectoryPackageRepository newInDirectory: path.

Path  can be both a string or a file reference. If the given path does not exist it will create it. If the given path is an already existing file it will fail with a FileExists exception.

Directory repositories store versions as follows:

 - packages are represented as subdirectories of the package directory.
 - versions are represented as files containing the serialized version information, and stored inside the corresponding package subdirectory.
"
Class {
	#name : #CGODirectoryPackageRepository,
	#superclass : #CGOPackageRepository,
	#instVars : [
		'rootDirectory'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
CGODirectoryPackageRepository class >> newInDirectory: aPathOrFileReference [
	
	^ self basicNew
		directory: aPathOrFileReference asFileReference;
		initialize;
		yourself
]

{ #category : #'instance creation' }
CGODirectoryPackageRepository class >> newWithFileName: aFileName [
	"ensure we can handle relative pathes"
	^ self newWithUrl: aFileName asFileReference fullName
]

{ #category : #accessing }
CGODirectoryPackageRepository >> directory: aFileReference [ 
	
	rootDirectory := aFileReference
]

{ #category : #private }
CGODirectoryPackageRepository >> directoryFor: aPackageVersion [
	^ (aPackageVersion isVirtual
		ifTrue: [ self virtualDirectory ]
		ifFalse: [ self rootDirectory ]) / aPackageVersion packageName asLowercase
]

{ #category : #'versions fetching' }
CGODirectoryPackageRepository >> fetch: aPackageName version: aVersion [
	| packageFolder packageVersionString |
	packageFolder := self rootDirectory / aPackageName asLowercase.
	packageFolder exists
		ifFalse: [ PBPackageNotFoundError signal: aPackageName ].
	packageVersionString := aPackageName asLowercase, '@', aVersion asString.
	(packageFolder / packageVersionString) exists 
		ifTrue: [ ^ CGOPackageVersion fromStonString: (packageFolder / packageVersionString) contents ]
		ifFalse: [ CGOPackageVersionNotFoundError signal ] 

]

{ #category : #'versions fetching' }
CGODirectoryPackageRepository >> fetchVirtual: aVirtualPackageName version: aVersion [
	| packageFolder packageVersionString |
	packageFolder := self virtualDirectory / aVirtualPackageName asLowercase.
	packageFolder exists
		ifFalse: [ PBPackageNotFoundError signal: aVirtualPackageName ].
	packageVersionString := aVirtualPackageName asLowercase, '@', aVersion asSemanticVersion asString.
	(packageFolder / packageVersionString) exists 
		ifTrue: [ ^ CGOVirtualPackageVersion fromStonString: (packageFolder / packageVersionString) contents ]
		ifFalse: [ CGOPackageVersionNotFoundError signal ] 

]

{ #category : #initialization }
CGODirectoryPackageRepository >> initialize [
	self rootDirectory ensureCreateDirectory.
	self virtualDirectory ensureCreateDirectory.
	self virtualIndexesDirectory ensureCreateDirectory.
]

{ #category : #initialization }
CGODirectoryPackageRepository >> initializeWithUrl: aUrlString [
	super initializeWithUrl: (ZnUrl fromString: aUrlString defaultScheme: #file).
	self initialize
]

{ #category : #private }
CGODirectoryPackageRepository >> latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes [
	^ ((self versionStringsOf: aPackageName) collect: #asPackageVersionReference)
			detectMax: [ :pkgVersion | pkgVersion versionNumber ]
]

{ #category : #fetching }
CGODirectoryPackageRepository >> package: aPackageName [
	^ (self rootDirectory / aPackageName asLowercase) exists
		ifTrue: [ CGOPackageProvider default packageNamed: aPackageName ]
		ifFalse: [ (self virtualDirectory / aPackageName asLowercase) exists
			ifTrue: [ CGOPackageProvider default virtualPackageNamed: aPackageName ]
			ifFalse: [ PBPackageNotFoundError signal: aPackageName ] ]
]

{ #category : #'versions fetching' }
CGODirectoryPackageRepository >> packageNames [
	"list name of all packages available in the repository"

	^ self rootDirectory directoryNames
		reject: [ :each | each = 'virtual' or: [ each = 'virtual-indexes' ] ]
]

{ #category : #private }
CGODirectoryPackageRepository >> packageVersionNamesProviding: aVirtualPackageName version: aSemanticVersion [
	| packages virtualPackageVersionIndex |
	packages := OrderedCollection new.
	virtualPackageVersionIndex := self virtualIndexesDirectory / aVirtualPackageName asLowercase / (aVirtualPackageName asLowercase , '@' , aSemanticVersion asString).
	^ virtualPackageVersionIndex exists 
		ifFalse: [ #() ]
		ifTrue: [ virtualPackageVersionIndex contents lines ]
]

{ #category : #'versions fetching' }
CGODirectoryPackageRepository >> packagesProviding: aVirtualPackageName version: aSemanticVersion forEnvironment: platformAttributes [
	^ (self packageVersionNamesProviding: aVirtualPackageName version: aSemanticVersion)
		collect: [ :packageVersionName | | pkgVersionRef |
			pkgVersionRef := packageVersionName asPackageVersionReference.
			self 
				fetch: pkgVersionRef packageName
				version: pkgVersionRef versionNumber ]
		thenSelect: [ :unit |
			self does: unit fitPlatformRequirements: platformAttributes ]
]

{ #category : #accessing }
CGODirectoryPackageRepository >> rootDirectory [
	^ rootDirectory ifNil: [ rootDirectory := baseUrl pathPrintString asFileReference ]
]

{ #category : #'versions posting' }
CGODirectoryPackageRepository >> savePackageVersion: aPackageVersion [
	| existingPackageVersion directory |
	existingPackageVersion := self checkPreviousRegistrationOf: aPackageVersion.
	directory := (self directoryFor: aPackageVersion) ensureCreateDirectory.
	directory / aPackageVersion name asLowercase
		writeStreamDo: [ :stream | 
			stream nextPutAll: (PBPackageVersionWriterV1 toStringPretty: aPackageVersion) ].
	self updateVirtualPackagesIndexWith: aPackageVersion
]

{ #category : #'versions posting' }
CGODirectoryPackageRepository >> updateVirtualPackagesIndexWith: aPackageVersion [
	aPackageVersion isAssembly ifTrue: [ ^ self ].
	aPackageVersion provisions
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ :provisions | 
			provisions 
				do: [ :virtualPackageVersionRef | | dir file |
					dir := (self virtualIndexesDirectory / virtualPackageVersionRef packageName asLowercase) ensureCreateDirectory.
					file :=  (dir / virtualPackageVersionRef asString asLowercase) ensureCreateFile.
					file
						writeStreamDo: [ :stream | 
							stream
								setToEnd;
								nextPutAll: aPackageVersion name;
								cr ] ] ]
]

{ #category : #'versions fetching' }
CGODirectoryPackageRepository >> versionStringsOf: aPackageName [
	"Returns the list of versions available in the repository for the given package name"

	^ [ (self rootDirectory / aPackageName asLowercase) fileNames
			collect: [ :fileName | 
				"Preserve possible upper case letters in the package name"
				aPackageName , PBPackageVersionReference packageVersionSeparator asString , (fileName copyAfterLast: PBPackageVersionReference packageVersionSeparator) ] ]
		on: DirectoryDoesNotExist 
		do: [ #() ]
]

{ #category : #'versions fetching' }
CGODirectoryPackageRepository >> versionStringsOfVirtual: aVirtualPackageName [
	"Returns the list of versions available in the repository for the given package name"

	^ [ (self virtualDirectory / aVirtualPackageName asLowercase) fileNames ]
		on: DirectoryDoesNotExist 
		do: [ #() ]
]

{ #category : #private }
CGODirectoryPackageRepository >> virtualDirectory [
	^ self rootDirectory / 'virtual'
]

{ #category : #private }
CGODirectoryPackageRepository >> virtualIndexesDirectory [
	^ self rootDirectory / 'virtual-indexes'
]
