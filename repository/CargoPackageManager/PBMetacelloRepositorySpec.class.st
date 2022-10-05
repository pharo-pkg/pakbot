"
I represent a Metacello Repository spec like:
- 'github://marianopeck/FFICHeaderExtractor:master/repository';
- 'github://dalehenrich/sample:configuration'
- 'github://pharo-contributions/OSSubprocess'
- 'github://pharo-spec/icetray/src'

Metacello URLs structure is the following:
github:// <github user> / <github project>  [ : <version identifier> ] [ / <repository path> ]

You can ask me to be converted to a git or a metacello URL.
"
Class {
	#name : #PBMetacelloRepositorySpec,
	#superclass : #Object,
	#instVars : [
		'url',
		'project',
		'owner',
		'version',
		'repositoryPath',
		'scheme'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #private }
PBMetacelloRepositorySpec class >> hostFromScheme: scheme [
	scheme = 'github'
		ifTrue: [ ^ 'github.com' ].
	scheme = 'gitlab'
		ifTrue: [ ^ 'gitlab.com' ].
	scheme = 'bitbucket'
		ifTrue: [ ^ 'bitbucket.org' ].
		
	self error: 'scheme ' , scheme , ' not supported in Metacello repository spec.'
]

{ #category : #accessing }
PBMetacelloRepositorySpec class >> metacelloSupportedSchemes [
	^ (MCGitBasedNetworkRepository subclasses 
			reject: #isAbstract
			thenCollect: #basicDescription) copyWith: 'gitlocal'
]

{ #category : #private }
PBMetacelloRepositorySpec class >> schemeFromHost: host [
	host = 'github.com'
		ifTrue: [ ^ 'github' ].
	host = 'gitlab.com'
		ifTrue: [ ^ 'gitlab' ].
	host = 'bitbucket.org'
		ifTrue: [ ^ 'bitbucket' ].
		
	self error: 'host ' , host , ' not supported in Metacello repository spec.'
]

{ #category : #'instance creation' }
PBMetacelloRepositorySpec class >> url: repositoryString [
	(self metacelloSupportedSchemes includes: repositoryString asZnUrl scheme)
		ifTrue: [ ^ self new
						url: repositoryString;
						yourself ]
		ifFalse: [ "http or git over ssh scheme" 
			^ self url: (PBGitUrl url: repositoryString) asMetacelloUrl ]

	
]

{ #category : #converting }
PBMetacelloRepositorySpec >> asGitUrl [

	url:=  'ssh://{host}{port}/{owner}/{project}.git' format: 
		( Dictionary 
			with: 'host' -> (self class hostFromScheme: self scheme)
			with: 'port' -> '' "Metacello URLs do not support port specfication"
			with: 'owner' -> self owner
			with: 'project' -> self project ).
	^ PBGitUrl url: url
]

{ #category : #converting }
PBMetacelloRepositorySpec >> asMetacelloUrl [

	^ '{scheme}://{owner}/{project}{version}{repositoryPath}' format: 
		( Dictionary 
			with: 'scheme' -> self scheme
			with: 'owner' -> self owner 
			with: 'project' -> self project
			with: 'version' -> (self version ifNil: [ '' ] ifNotNil: [ ':', self version ])
			with: 'repositoryPath' -> (self repositoryPath  ifNil: [ '' ] ifNotNil: [ '/', self repositoryPath ]) )
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> basicUrl [

	^ url
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> owner [
	^ owner
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> owner: aString [ 
	owner := aString
]

{ #category : #parsing }
PBMetacelloRepositorySpec >> parseOwnerStartAt: startIndex [
	| index |
	index := url indexOf: $/ startingAt: startIndex ifAbsent: [ self error: 'Metacello repository spec must define an owner!' ].
	owner := url copyFrom: startIndex to: index - 1.
	
	^ index + 1.
]

{ #category : #parsing }
PBMetacelloRepositorySpec >> parseProjectStartAt: startIndex [
	| index |
	index := url indexOfAnyOf: '/:' startingAt: startIndex ifAbsent: [ url size + 1 ].
	project := url copyFrom: startIndex to: index - 1.
	
	^ index "next parsing needs to know if the character found is $/ or $:"
]

{ #category : #parsing }
PBMetacelloRepositorySpec >> parseRepositoryPathStartAt: startIndex [
	startIndex < url size ifFalse: [ ^ startIndex ].
	repositoryPath :=  url copyFrom: startIndex to: url size.
]

{ #category : #parsing }
PBMetacelloRepositorySpec >> parseScheme [
	| index |
	((index := url indexOfSubCollection: '://') > 0)
		ifTrue: [ scheme := url copyFrom: 1 to: index -1.
					^ index + 3].
]

{ #category : #parsing }
PBMetacelloRepositorySpec >> parseUrl [
	| start |
	start := self parseScheme.
	start := self parseOwnerStartAt: start.
	start := self parseProjectStartAt: start.
	start := self parseVersionStartAt: start.
	self parseRepositoryPathStartAt: start
	
]

{ #category : #parsing }
PBMetacelloRepositorySpec >> parseVersionStartAt: startIndex [
	| index |
	startIndex < url size ifFalse: [ ^ startIndex ].
	(url at: startIndex) = $: ifFalse: [ ^ startIndex + 1 "no version" ].
	
	index := url indexOf: $/ startingAt: startIndex + 1 ifAbsent: [ url size + 1 ].
	version := url copyFrom: startIndex + 1 to: index - 1.
	^ index + 1
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> project [
	^ project
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> project: aString [ 
	project := aString
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> repositoryPath [
	^ repositoryPath
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> scheme [
	^ scheme
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> scheme: aString [ 
	scheme := aString
]

{ #category : #initialization }
PBMetacelloRepositorySpec >> url: aString [ 
	url := aString.
	self parseUrl.
]

{ #category : #converting }
PBMetacelloRepositorySpec >> urlWithoutVersion [

	^ '{scheme}://{owner}/{project}{repositoryPath}' format: 
		( Dictionary 
			with: 'scheme' -> self scheme
			with: 'owner' -> self owner 
			with: 'project' -> self project
			with: 'repositoryPath' -> (self repositoryPath  ifNil: [ '' ] ifNotNil: [ '/', self repositoryPath ]) )
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> version [
	^ version
]

{ #category : #accessing }
PBMetacelloRepositorySpec >> version: aVersionString [
	version := aVersionString
]
