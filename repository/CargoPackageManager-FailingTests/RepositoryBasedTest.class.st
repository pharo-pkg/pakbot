Class {
	#name : #RepositoryBasedTest,
	#superclass : #CGOTest,
	#instVars : [
		'repository'
	],
	#category : 'CargoPackageManager-FailingTests-Solver'
}

{ #category : #'set up' }
RepositoryBasedTest >> setUp [
	super setUp.
	repository := CGOMemoryRepository new.
	self packageVersions do: #save.
	self packages do: #save.
	self virtualPackages do: #save.
	self virtualPackageVersions do: #save.
]

{ #category : #accessing }
RepositoryBasedTest >> voyageRepository [
	^ repository instVarNamed: 'voyageRepository' 
]
