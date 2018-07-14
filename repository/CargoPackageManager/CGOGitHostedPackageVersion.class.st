"
I represent a package version containing source code hosted on a Git server.

- commitish allows to identify the package version. It could be either a commit id (hash) or a tag
"
Class {
	#name : #CGOGitHostedPackageVersion,
	#superclass : #CGOSourcePackageVersion,
	#instVars : [
		'commitish'
	],
	#category : 'CargoPackageManager-Loading'
}

{ #category : #example }
CGOGitHostedPackageVersion class >> cargoGitRepository [
	^ self
		repositoryUrl: 'git@github.com:demarey/cargo.git'
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: 'b9ee048f40e500198120aedf8db60266caa9ece9'
]

{ #category : #'instance creation' }
CGOGitHostedPackageVersion class >> repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitish [
	^ self basicNew 
		repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitish;
		yourself
]

{ #category : #private }
CGOGitHostedPackageVersion >> ensureIcePackageNamed: aPackageName [
	| iceRepository |
	iceRepository := self iceRepository.
	^ [ iceRepository packageNamed: packageName ]
		on: NotFound 
		do: [ iceRepository addPackageNamed: aPackageName ]
]

{ #category : #private }
CGOGitHostedPackageVersion >> iceRepository [
	^ repository iceRepository
]

{ #category : #fetching }
CGOGitHostedPackageVersion >> loadMetadata [
	| iceRepository |
	iceRepository := self iceRepository.
	^ [ iceRepository
		contentOfFileNamed: self metadataPath 
		commit: iceRepository headCommit id ]
		on: Error
		do: [ :error | CGOPackageMetadataNotFound signal: error messageText ]
]

{ #category : #accessing }
CGOGitHostedPackageVersion >> mcVersion [
	| iceSavedPackage icePackageVersion |
	iceSavedPackage := self iceRepository packageNamed: packageName.
	icePackageVersion := commitish
		ifNil: [ iceSavedPackage latestVersion ]
		ifNotNil: [ iceSavedPackage versionFor: commitish ].
	^ icePackageVersion mcVersion
]

{ #category : #accessing }
CGOGitHostedPackageVersion >> metadata [
	^ self iceRepository 
		contentOfFileNamed: self metadataPath
		commit: commitish 
]

{ #category : #private }
CGOGitHostedPackageVersion >> metadataDirectory [
	^ repository codeDirectoryRelativePath , packageName , '.package'
]

{ #category : #private }
CGOGitHostedPackageVersion >> metadataFileName [
	^ 'package-metadata.ston'
]

{ #category : #private }
CGOGitHostedPackageVersion >> metadataPath [
	^ self metadataDirectory , '/' , self metadataFileName
]

{ #category : #initialization }
CGOGitHostedPackageVersion >> repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitOrTag [
	repository:= CGOGitRepository 
		repositoryUrl: gitUrlString
		subdirectory: directoryName.
	packageName := pkgName asSymbol.
	commitish := commitOrTag 

]

{ #category : #saving }
CGOGitHostedPackageVersion >> saveAndCommitWithMessage: message andMetadataString: stonString [
	self saveWithMessage: message andMetadataString: stonString.
	^ self iceRepository 
		commitIndexWithMessage: message
		andParents: { self iceRepository headCommit }
]

{ #category : #saving }
CGOGitHostedPackageVersion >> saveMetadataToIndex: stonString [
	^ self iceRepository 
		saveContent: stonString 
		inWorkingCopyFile: self metadataPath
]

{ #category : #saving }
CGOGitHostedPackageVersion >> savePackageSourcesToIndexWithMessage: message [
	| iceRepository newMcVersion |
	iceRepository := self iceRepository.
	newMcVersion := iceRepository 
		internalSavePackage: (self ensureIcePackageNamed: packageName)
		withMessage: message.
	iceRepository addFilesToIndex: { iceRepository directoryForPackage: newMcVersion package }.
	^ newMcVersion
]

{ #category : #saving }
CGOGitHostedPackageVersion >> saveWithMessage: message andMetadataString: stonString [
	self savePackageSourcesToIndexWithMessage: message.
	self saveMetadataToIndex: stonString
]
