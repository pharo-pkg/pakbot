"
Set up of credentials on CI infrastructure is not always easy but mandatory to run tests using 'git@xxx' urls.
To avoid to force the URL change in tests, this class will just rewrite the reposiory URL to ensure an https url  or a SSH url according to useHttps url flag.
"
Class {
	#name : #CGOGitHostedPackageVersionEnforcingProtocol,
	#superclass : #CGOGitHostedPackageVersion,
	#classVars : [
		'useHttpsUrl'
	],
	#category : 'CargoPackageManager-Tests-SCM'
}

{ #category : #initialization }
CGOGitHostedPackageVersionEnforcingProtocol class >> initialize [
	self useHttpsUrl
]

{ #category : #configuring }
CGOGitHostedPackageVersionEnforcingProtocol class >> useHttpsUrl [
	useHttpsUrl := true
]

{ #category : #configuring }
CGOGitHostedPackageVersionEnforcingProtocol class >> useSshUrl [
	useHttpsUrl := false
]

{ #category : #converting }
CGOGitHostedPackageVersionEnforcingProtocol >> httpUrlFrom: aString [ 
	| matcher |
	matcher := 'git@((\w|\d|\.)+)\:(\w+)/(\w+).git' asRegex.
	^ (matcher matches: aString) 
		ifTrue: [ 'https://', (matcher subexpression: 2) , '/' , (matcher subexpression: 4), '/', (matcher subexpression: 5) ]
		ifFalse: [ aString ]
		
]

{ #category : #initialization }
CGOGitHostedPackageVersionEnforcingProtocol >> repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitOrTag [
	repository:= PBGitRepository 
		repositoryUrl: (useHttpsUrl 
			ifTrue: [ self httpUrlFrom: gitUrlString ]
			ifFalse: [ self sshUrlFrom: gitUrlString ])
		subdirectory: directoryName.
	packageName := pkgName asSymbol.
	commitish := commitOrTag 
]

{ #category : #converting }
CGOGitHostedPackageVersionEnforcingProtocol >> sshUrlFrom: aString [ 
	| matcher |
	matcher := 'https\://((\w|\d|\.)+)/(.+)' asRegex.
	^ (matcher matches: aString) 
		ifTrue: [ 'git@', (matcher subexpression: 2) , ':' , (matcher subexpression: 4), '.git' ]
		ifFalse: [ aString ]
		
]
