Class {
	#name : #PBMetacelloRepositorySpecTest,
	#superclass : #FileTestCase,
	#category : #'CargoPackageManager-Tests-SCM'
}

{ #category : #test }
PBMetacelloRepositorySpecTest >> testAsMetacelloUrl [
	self
		assert: (PBMetacelloRepositorySpec url: 'github://marianopeck/FFICHeaderExtractor:master/repository') asMetacelloUrl 
		equals: 'github://marianopeck/FFICHeaderExtractor:master/repository'.
		
	self
		assert: (PBMetacelloRepositorySpec url: 'github://marianopeck/FFICHeaderExtractor/repository') asMetacelloUrl 
		equals: 'github://marianopeck/FFICHeaderExtractor/repository'.
		
	self
		assert: (PBMetacelloRepositorySpec url: 'github://marianopeck/FFICHeaderExtractor:master') asMetacelloUrl 
		equals: 'github://marianopeck/FFICHeaderExtractor:master'.
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanBeConvertedToGitUrl [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://marianopeck/FFICHeaderExtractor:master/repository'.

	self
		assert: spec asGitUrl scpUrl
		equals: 'git@github.com:marianopeck/FFICHeaderExtractor.git'
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanBeInitializedFromString [
	"test we do not return a PBGirUrl when giving a Metacello repository spec"
	
	self 
		assert: 'github://marianopeck/FFICHeaderExtractor:master/repository' asGitUrlOrMetacelloRepositorySpec class 
		equals: PBMetacelloRepositorySpec.
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanConvertGitOverSShRepositoryDescription [
	| spec |
	spec := 'git@github.com:pharo-contributions/OSSubprocess.git' asMetacelloRepositorySpec.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'pharo-contributions'.
		
	self assert: spec project
		equals: 'OSSubprocess'.
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanConvertHttpRepositoryDescription [
	| spec |
	spec := 'https://github.com/pharo-contributions/OSSubprocess.git' asMetacelloRepositorySpec.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'pharo-contributions'.
		
	self assert: spec project
		equals: 'OSSubprocess'.
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanConvertMetacelloGitHubRepositoryDescription [
	| spec |
	spec := 'github://marianopeck/FFICHeaderExtractor:master/repository' asMetacelloRepositorySpec.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'marianopeck'.
		
	self assert: spec project
		equals: 'FFICHeaderExtractor'.
		
	self
		assert: spec version
		equals: 'master'.	
		
	self
		assert: spec repositoryPath 
		equals: 'repository'.	
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanGetUrlWithoutVersion [
	| spec |
	spec := 'github://marianopeck/FFICHeaderExtractor:master/repository' asMetacelloRepositorySpec.

	self
		assert: spec urlWithoutVersion 
		equals: 'github://marianopeck/FFICHeaderExtractor/repository'
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseGitHubUrlWithRepositoryPath [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://pharo-spec/icetray/repo/sitory/path'.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'pharo-spec'.
		
	self assert: spec project
		equals: 'icetray'.
		
	self
		assert: spec repositoryPath
		equals: 'repo/sitory/path'.	
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseGitHubUrlWithSimpleRepositoryPath [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://pharo-spec/icetray/src'.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'pharo-spec'.
		
	self assert: spec project
		equals: 'icetray'.
		
	self
		assert: spec repositoryPath
		equals: 'src'.	
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseGitHubUrlWithVersion [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://dalehenrich/sample:configuration'.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'dalehenrich'.
		
	self assert: spec project
		equals: 'sample'.
		
	self
		assert: spec version
		equals: 'configuration'.	
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseGitHubUrlWithVersionAndRepositoryPath [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://marianopeck/FFICHeaderExtractor:master/repository'.

	self
		assert: spec scheme
		equals: 'github'.
			
	self 
		assert: spec owner
		equals: 'marianopeck'.
		
	self assert: spec project
		equals: 'FFICHeaderExtractor'.
		
	self
		assert: spec version
		equals: 'master'.	
		
	self
		assert: spec repositoryPath 
		equals: 'repository'.	
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseGitLocalUrl [
	| directory spec |
	directory := self newTempDirectory.
	spec := PBMetacelloRepositorySpec url: 'gitlocal://', directory fullName.
	
	self
		assert: spec scheme
		equals: 'gitlocal'.

	self assert: (spec basicUrl endsWith: directory fullName).
]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseSimpleGitHubUrl [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://pharo-contributions/OSSubprocess'.
	
	self
		assert: spec scheme
		equals: 'github'.

	self assert: spec owner
		equals: 'pharo-contributions'.

	self 
		assert: spec project
		equals: 'OSSubprocess'.

]

{ #category : #tests }
PBMetacelloRepositorySpecTest >> testCanParseSimpleGitHubUrlWithTrailingSlash [
	| spec |
	spec := PBMetacelloRepositorySpec url: 'github://pharo-contributions/OSSubprocess/'.
	
	self
		assert: spec scheme
		equals: 'github'.
		
	self assert: spec owner
		equals: 'pharo-contributions'.
					
	self 
		assert: spec project
		equals: 'OSSubprocess'.

]
