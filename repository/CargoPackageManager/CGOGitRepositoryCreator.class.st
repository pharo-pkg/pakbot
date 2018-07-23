"
Builder to create IceRepository objetcs.

You can use it to set:
- git url
- packages subdirectory
- git version referenced (may be a tag, a branch or a commit hash)
"
Class {
	#name : #CGOGitRepositoryCreator,
	#superclass : #Object,
	#instVars : [
		'url',
		'version',
		'subdirectory',
		'location'
	],
	#category : 'CargoPackageManager-Loading'
}

{ #category : #example }
CGOGitRepositoryCreator class >> example [
	^ self new
		url: 'git://git@github.com/demarey/pharo-counter.git';
		version: 'master';
		create.
]

{ #category : #testing }
CGOGitRepositoryCreator class >> isGitHubScheme: url [
	^ url scheme = #github
]

{ #category : #private }
CGOGitRepositoryCreator class >> normalizeUrl: aString [ 
	| colonIndex |
	colonIndex := aString indexOf: $:.
	^ aString copyReplaceFrom: colonIndex to: colonIndex with: '/'
]

{ #category : #action }
CGOGitRepositoryCreator class >> repositoryCreatorWithUrl: urlOrString [
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
CGOGitRepositoryCreator class >> repositoryFromIceRepository: anIceRepository [ 
	^ CGOGitRepository 
		url: anIceRepository origin url
		repository: anIceRepository
		version: anIceRepository branchName
]

{ #category : #action }
CGOGitRepositoryCreator class >> repositoryFromUrl: urlOrString [
	^ (self repositoryCreatorWithUrl: urlOrString) create
]

{ #category : #converting }
CGOGitRepositoryCreator class >> urlWithScheme: anUrlStringOrUrl [ 
	^ (anUrlStringOrUrl asString beginsWith: 'git@')
		ifTrue: [ ('git://' , (self normalizeUrl: anUrlStringOrUrl asString)) asZnUrl ]
		ifFalse: [ anUrlStringOrUrl asZnUrl ]
]

{ #category : #querying }
CGOGitRepositoryCreator >> commitishFrom: anUrl [
	^ (anUrl lastPathSegment includes: $:)
		ifTrue: [ anUrl asString copyAfterLast: $: ]
		ifFalse: [ nil ]
]

{ #category : #building }
CGOGitRepositoryCreator >> create [
	| iceRepository |
	iceRepository := IceRepositoryCreator new 
			addRemote: url;
			subdirectory: subdirectory;
			location: location";
			To fix: iceRepository".
	^ CGOGitRepository 
		url: url
		repository: iceRepository
		version: version
]

{ #category : #building }
CGOGitRepositoryCreator >> createAndClone [
	^ self create
		ensureCloned;
		yourself
]

{ #category : #setting }
CGOGitRepositoryCreator >> githubUrl: aStringOrUrl [

	self url: aStringOrUrl
]

{ #category : #converting }
CGOGitRepositoryCreator >> icebergUrl [
	^ self isGitOverSshScheme
		ifTrue: [ String streamContents: [ :stream | | path |
				url printAuthorityOn: stream.
				path := String streamContents: [ :pathStream | url printPathQueryFragmentOn: pathStream  ].
				stream << $: << path allButFirst. "ZnUrl adds a $/ as first path segment. Not a valid url for iceberg" ] ]
		ifFalse: [ url asString ]
]

{ #category : #initialization }
CGOGitRepositoryCreator >> initialize [
	location := nil
]

{ #category : #testing }
CGOGitRepositoryCreator >> isGitOverSshScheme [
	^ url scheme = #'git+ssh'
]

{ #category : #setting }
CGOGitRepositoryCreator >> location: aFileReference [
	location := aFileReference
]

{ #category : #setting }
CGOGitRepositoryCreator >> subdirectory: aString [ 
	subdirectory := aString
]

{ #category : #setting }
CGOGitRepositoryCreator >> url: aStringOrUrl [

	url := aStringOrUrl asString
]

{ #category : #setting }
CGOGitRepositoryCreator >> version: aCommitishString [
	"a version can be a reference to a git branch, a git tag or a git commit" 
	version := aCommitishString
]
