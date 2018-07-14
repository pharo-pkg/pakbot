"
I offer a REST interface on / with operations available on PPMRepository.
I use STON to exchange data.

Based on my URI space I dispatch requests to REST call objects. I automatically use the call hierarchy below PPMRepositoryRestCall.

To install me you can do:

	ZnServer startDefaultOn: 8080.
	ZnServer default 
		logToTranscript;
		delegate: (PPMRepositoryRestServerDelegate newWith: PPMTestPackageRepository new).
		debugMode: true.
			
	ZnServer stopDefault.
"
Class {
	#name : #CGORepositoryRestServerDelegate,
	#superclass : #ZnRestServerDelegate,
	#instVars : [
		'packageRepository'
	],
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #'instance creation' }
CGORepositoryRestServerDelegate class >> newWith: aPackageRepository [
	^ self basicNew 
		initializeWithRepository: aPackageRepository
]

{ #category : #initialization }
CGORepositoryRestServerDelegate >> initializeWithRepository: aPackageRepository [
	super initialize.
	packageRepository := aPackageRepository.
	self uriSpace: ZnCallHierarchyRestUriSpace new.
	self uriSpace rootClass: CGORepositoryRestCallHandler
]

{ #category : #accessing }
CGORepositoryRestServerDelegate >> packageRepository [
	^ packageRepository
]
