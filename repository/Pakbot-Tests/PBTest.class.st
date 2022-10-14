"
I'm a test case provinding a default package registry that is only used during the test exection.
"
Class {
	#name : #PBTest,
	#superclass : #TestCase,
	#instVars : [
		'registry'
	],
	#category : #'Pakbot-Tests-Model'
}

{ #category : #running }
PBTest >> newApplicationWithRegistry [
	
	| app |
	app := SpApplication newAnonymousSubclass 
			addSlot: #registry;
			compile: 'registry ^ registry';
			compile: 'registry: aRegistry registry := aRegistry';
			new.
		app registry: registry.
		^ app
]

{ #category : #private }
PBTest >> performTest [
	PBPackageRegistry 
		useDefaultRegistry: registry
		during: [ self perform: testSelector asSymbol ]
]

{ #category : #running }
PBTest >> setUp [
	super setUp.
	registry := PBPackageRegistry new
]

{ #category : #running }
PBTest >> tearDown [
	
	registry unregisterFromSystem.
	super tearDown.
]
