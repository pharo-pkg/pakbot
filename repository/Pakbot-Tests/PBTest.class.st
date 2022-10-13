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
