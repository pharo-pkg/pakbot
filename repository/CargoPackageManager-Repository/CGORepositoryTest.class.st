Class {
	#name : #CGORepositoryTest,
	#superclass : #CGOTest,
	#instVars : [
		'server',
		'client'
	],
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #accessing }
CGORepositoryTest >> defaultTimeLimit [
	^ 5 seconds 
]

{ #category : #running }
CGORepositoryTest >> setUp [
	| delegate |
	delegate := CGORepositoryRestServerDelegate newWith: CGOTestPackageRepository new.
	server := ZnServer startOn: 1800 + 10 atRandom.
	server 
		delegate: delegate;
		debugMode: true;
		yourself.
	
	client := ZnClient new
		url: server localUrl;
		accept: ZnMimeType applicationSton;
		enforceHttpSuccess: true;
		contentReader: [ :entity | entity ifNotNil: [ STON fromString: entity contents ] ];
		contentWriter: [ :object | ZnEntity with: (CGOPackageVersionWriter toStringPretty: object) type: ZnMimeType applicationSton ];
		yourself
]

{ #category : #running }
CGORepositoryTest >> tearDown [
	client close.
	server stop
]
