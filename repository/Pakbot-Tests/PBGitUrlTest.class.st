"
A PBGitUrlTest is a test class for testing the behavior of PBGitUrl
"
Class {
	#name : #PBGitUrlTest,
	#superclass : #TestCase,
	#category : #'Pakbot-Tests-Model'
}

{ #category : #tests }
PBGitUrlTest >> testCanBeConvertedToMetacelloUrl [
	self
		assert: (PBGitUrl url: 'ssh://git@github.com/demarey/pharo-counter.git') asMetacelloUrl
		equals: 'github://demarey/pharo-counter'
]

{ #category : #tests }
PBGitUrlTest >> testCanBeInitializedFromString [
	"test we do not return a PBMetacelloRepositorySpec when giving a valid git URL"
	
	self 
		assert: 'git://git@github.com/demarey/pharo-counter.git' asGitUrlOrMetacelloRepositorySpec class 
		equals: PBGitUrl.
]

{ #category : #tests }
PBGitUrlTest >> testCanBeInitializedOnGitUrl [
	| gitUrl |
	gitUrl := PBGitUrl url: 'git://git@github.com/demarey/pharo-counter.git'.

	self 
		assert: gitUrl scheme 
		equals: 'git'.
		
	self
		assert: gitUrl host
		equals: 'github.com'.
		
	self
		assert: gitUrl user
		equals: 'git'.

	self
		assert: gitUrl owner
		equals: 'demarey'.
	
	self 
		assert: gitUrl project 
		equals: 'pharo-counter'.
]

{ #category : #tests }
PBGitUrlTest >> testCanBeInitializedOnGitUrlWithoutScheme [
	| gitUrl |
	gitUrl := PBGitUrl url: 'git@github.com:demarey/pharo-counter.git'.

	self 
		assert: gitUrl scheme 
		equals: 'ssh'.
		
	self
		assert: gitUrl host
		equals: 'github.com'.
		
	self
		assert: gitUrl user
		equals: 'git'.

	self
		assert: gitUrl owner
		equals: 'demarey'.
	
	self 
		assert: gitUrl project 
		equals: 'pharo-counter'.
]

{ #category : #tests }
PBGitUrlTest >> testCanBeInitializedOnHttpUrl [
	| gitUrl |
	gitUrl := PBGitUrl url: 'https://github.com/demarey/pharo-counter.git'.

	self 
		assert: gitUrl scheme 
		equals: 'https'.
		
	self
		assert: gitUrl host
		equals: 'github.com'.

	self
		assert: gitUrl owner
		equals: 'demarey'.
	
	self 
		assert: gitUrl project 
		equals: 'pharo-counter'.
]

{ #category : #tests }
PBGitUrlTest >> testCanGetHttpUrl [
	self
		assert: (PBGitUrl url: 'git@github.com/demarey/pharo-counter.git') httpUrl
		equals: 'https://github.com/demarey/pharo-counter.git'
]

{ #category : #tests }
PBGitUrlTest >> testCanGetScpUrl [
	self
		assert: (PBGitUrl url: 'https://github.com/demarey/pharo-counter.git') scpUrl
		equals: 'git@github.com:demarey/pharo-counter.git'
]
