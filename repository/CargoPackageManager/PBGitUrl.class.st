"
I represent an url referering to a git repository.
It can be either an HTTP or a git URL.
Some examples
•	'git@github.com:demarey/pharo-counter.git'
•	'https://github.com/demarey/pharo-counter.git'
•	'git://git@github.com/demarey/pharo-counter.git'

You can ask me to be converted to an http, an scp URL or a metacello repository URL (in this case, version and Smalltalk source repository path will not be initialized).

I can be use by Iceberg to specify a repository location.
"
Class {
	#name : #PBGitUrl,
	#superclass : #Object,
	#instVars : [
		'originUrlString',
		'url'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #testing }
PBGitUrl class >> canHandleUrl: aString [ 
	| url |
	url := aString asUrl.
	
	^ url hasScheme not or: [ url isHttp or: [url isHttps or: [ url scheme = 'git' ] ] ]
]

{ #category : #'instance creation' }
PBGitUrl class >> url: aString [ 
	^ self new
		url: aString;
		yourself
]

{ #category : #converting }
PBGitUrl >> asGitUrl [ 
	^ self
]

{ #category : #converting }
PBGitUrl >> asMetacelloUrl [

	^ '{scheme}://{owner}/{project}{version}{repositoryPath}' format: 
		( Dictionary 
			with: 'scheme' -> (PBMetacelloRepositorySpec schemeFromHost: self host)
			with: 'owner' -> self owner 
			with: 'project' -> self project
			with: 'version' -> ''
			with: 'repositoryPath' -> '' )
	
]

{ #category : #accessing }
PBGitUrl >> ensureScheme [
	url scheme ifNotNil: [ ^ self ].
	
	[ url := ('git+ssh://' , originUrlString) asZnUrl ]
		on: ZnPortNotANumber
		do: [ url := ('git+ssh://' , (originUrlString replaceAll: $: with: $/)) asZnUrl ]
]

{ #category : #accessing }
PBGitUrl >> host [
	^ url host
]

{ #category : #accessing }
PBGitUrl >> httpUrl [
	^ 'https://{host}/{owner}/{project}.git' format: 
		( Dictionary 
			with: 'host' -> self host
			with: 'owner' -> self owner 
			with: 'project' -> self project)
]

{ #category : #accessing }
PBGitUrl >> owner [
	^ url segments first
]

{ #category : #accessing }
PBGitUrl >> port [
	^ ''
]

{ #category : #accessing }
PBGitUrl >> project [
	^ url segments second withoutSuffix: '.git'
]

{ #category : #accessing }
PBGitUrl >> scheme [
	^ url scheme
]

{ #category : #accessing }
PBGitUrl >> scpUrl [
	^ '{user}@{host}:{owner}/{project}.git' format: 
		( Dictionary 
			with: 'user' -> (self user ifNil: ['git'])
			with: 'host' -> self host
			with: 'owner' -> self owner 
			with: 'project' -> self project)
]

{ #category : #initialization }
PBGitUrl >> url: aString [ 
	originUrlString := aString.
	url := originUrlString asZnUrl.
	self ensureScheme.
]

{ #category : #accessing }
PBGitUrl >> user [
	^ url username
]
