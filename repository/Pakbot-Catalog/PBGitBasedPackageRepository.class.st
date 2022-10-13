"
I am a package repository used to host the meta data of Packbot packages / projects.
I use a git repository as backend.

root will be the root of the git working copy.
"
Class {
	#name : #PBGitBasedPackageRepository,
	#superclass : #PBPackageRepository,
	#instVars : [
		'repository'
	],
	#category : #'Pakbot-Catalog'
}

{ #category : #initialization }
PBGitBasedPackageRepository class >> defaultGitUrl [
	^ 'https://github.com/pharo-pkg/project-repository.git'
]

{ #category : #'instance creation' }
PBGitBasedPackageRepository class >> newEmptyLocalRepositoryIn: aFileReference [ 
	^ self basicNew 
		root: aFileReference;
		initializeEmptyRepository;
		yourself
]

{ #category : #'instance creation' }
PBGitBasedPackageRepository class >> newLocalRepositoryIn: aFileReference [ 
	^ self basicNew 
		root: aFileReference;
		initialize;
		yourself
]

{ #category : #accessing }
PBGitBasedPackageRepository >> head [
	^ self iceRepository head
]

{ #category : #private }
PBGitBasedPackageRepository >> iceRepository [
	^ repository iceRepository
]

{ #category : #initialization }
PBGitBasedPackageRepository >> initialize [
	self initializeRepositoryOnUrl: self class defaultGitUrl.
]

{ #category : #initialization }
PBGitBasedPackageRepository >> initializeEmptyRepository [
	self initializeRepositoryOnUrl: 'file://', root fullName.
]

{ #category : #private }
PBGitBasedPackageRepository >> initializeRepositoryOnUrl: url [
	repository := PBGitRepositoryCreator new
		url: url;
		location: root;
		createAndClone.
	root := self workingCopy fileSystem.
]

{ #category : #saving }
PBGitBasedPackageRepository >> saveProject: aPBProjectVersion [
	super saveProject: aPBProjectVersion.
	self iceRepository commitIndexWithMessage: aPBProjectVersion name, ' ', aPBProjectVersion version asString
		andParents: { self iceRepository headCommit }.
]

{ #category : #accessing }
PBGitBasedPackageRepository >> url [
	
	^ repository repositoryUrl
]

{ #category : #accessing }
PBGitBasedPackageRepository >> workingCopy [
	^ self iceRepository workingCopy
]
