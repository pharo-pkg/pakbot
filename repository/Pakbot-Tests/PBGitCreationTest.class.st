"
super class used to set up credentials to perform git operations (i.e. clone)
"
Class {
	#name : #PBGitCreationTest,
	#superclass : #PBTestCaseWithGitCredentials,
	#instVars : [
		'repository',
		'iceRepositoryLocation'
	],
	#category : #'Pakbot-Tests-Repository'
}

{ #category : #accessing }
PBGitCreationTest >> iceRepositoryLocation [
	^ iceRepositoryLocation
		ifNil: [ iceRepositoryLocation := FileLocator temp
				/ ('pharo-tests-' , DateAndTime now asFileNameCompatibleString) ]
]

{ #category : #running }
PBGitCreationTest >> tearDown [
	repository ifNotNil: 
		[ (repository instVarNamed: 'iceRepository') ifNotNil: "do not call the accessor that will force the repository clone"
			[ :aRepository | aRepository delete ] ].
	
	iceRepositoryLocation ifNotNil: #ensureDeleteAll.
	
	super tearDown.
]
