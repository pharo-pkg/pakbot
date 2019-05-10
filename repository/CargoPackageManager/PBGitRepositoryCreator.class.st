"
Builder to create IceRepository objetcs.

You can use it to set:
- git url
- packages subdirectory
- git version referenced (may be a tag, a branch or a commit hash)
"
Class {
	#name : #PBGitRepositoryCreator,
	#superclass : #Object,
	#instVars : [
		'url',
		'version',
		'subdirectory',
		'location'
	],
	#category : #'CargoPackageManager-Loading'
}

{ #category : #example }
PBGitRepositoryCreator class >> example [
	^ self new
		url: 'git://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
]

{ #category : #testing }
PBGitRepositoryCreator class >> isGitHubScheme: url [
	^ url scheme = #github
]

{ #category : #private }
PBGitRepositoryCreator class >> normalizeUrl: aString [ 
	| colonIndex |
	colonIndex := aString indexOf: $:.
	^ aString copyReplaceFrom: colonIndex to: colonIndex with: '/'
]

{ #category : #action }
PBGitRepositoryCreator class >> repositoryCreatorWithUrl: urlOrString [
	| url |
	url := self urlWithScheme: urlOrString.
	^ (self isGitHubScheme: url)
		ifTrue: [ self new 
						githubUrl: url;
						yourself ]
		ifFalse: [ self new
						url: url;
						yourself ]
]

{ #category : #action }
PBGitRepositoryCreator class >> repositoryFromIceRepository: anIceRepository [ 
	^ PBGitRepository 
		url: anIceRepository origin url
		repository: anIceRepository
		version: anIceRepository branchName
]

{ #category : #action }
PBGitRepositoryCreator class >> repositoryFromUrl: urlOrString [
	^ (self repositoryCreatorWithUrl: urlOrString) create
]

{ #category : #converting }
PBGitRepositoryCreator class >> urlWithScheme: anUrlStringOrUrl [ 
	^ (anUrlStringOrUrl asString beginsWith: 'git@')
		ifTrue: [ ('git://' , (self normalizeUrl: anUrlStringOrUrl asString)) asZnUrl ]
		ifFalse: [ anUrlStringOrUrl asZnUrl ]
]

{ #category : #querying }
PBGitRepositoryCreator >> commitishFrom: anUrl [
	^ (anUrl lastPathSegment includes: $:)
		ifTrue: [ anUrl asString copyAfterLast: $: ]
		ifFalse: [ nil ]
]

{ #category : #building }
PBGitRepositoryCreator >> create [
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			subdirectory: subdirectory;
			location: location";
			To fix: iceRepository".
	url ifNotNil: [ iceRepository addRemote: url ].
	^ PBGitRepository 
		url: url
		repository: iceRepository
		version: version
]

{ #category : #building }
PBGitRepositoryCreator >> createAndClone [
	^ self create
		ensureCloned;
		yourself
]

{ #category : #building }
PBGitRepositoryCreator >> createNewRepositoryNamed: aString [ 
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
		location: location;
		createNewRepositoryNamed: aString.
			
	^ PBGitRepository repository: iceRepository
]

{ #category : #setting }
PBGitRepositoryCreator >> githubUrl: aStringOrUrl [

	self url: aStringOrUrl
]

{ #category : #converting }
PBGitRepositoryCreator >> icebergUrl [
	^ self isGitOverSshScheme
		ifTrue: [ String streamContents: [ :stream | | path |
				url printAuthorityOn: stream.
				path := String streamContents: [ :pathStream | url printPathQueryFragmentOn: pathStream  ].
				stream << $: << path allButFirst. "ZnUrl adds a $/ as first path segment. Not a valid url for iceberg" ] ]
		ifFalse: [ url asString ]
]

{ #category : #initialization }
PBGitRepositoryCreator >> initialize [
	location := nil
]

{ #category : #testing }
PBGitRepositoryCreator >> isGitOverSshScheme [
	^ url scheme = #'git+ssh'
]

{ #category : #setting }
PBGitRepositoryCreator >> location: aFileReference [
	location := aFileReference
]

{ #category : #setting }
PBGitRepositoryCreator >> subdirectory: aString [ 
	subdirectory := aString
]

{ #category : #setting }
PBGitRepositoryCreator >> url: aStringOrUrl [

	url := aStringOrUrl asString
]

{ #category : #setting }
PBGitRepositoryCreator >> version: aCommitishString [
	"a version can be a reference to a git branch, a git tag or a git commit" 
	version := aCommitishString
]
