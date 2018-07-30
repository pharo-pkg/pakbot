Class {
	#name : #PaCasesMatrixTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'option1',
		'option2'
	],
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #private }
PaCasesMatrixTest class >> testParameters [

	^ ParametrizedTestMatrix new
		addCase: { #option1 -> 'a'. #option2 -> 1};
		addCase: { #option1 -> 'b'. #option2 -> 2};		
		addCase: { #option1 -> 'c'. #option2 -> 3};		
		yourself.
]

{ #category : #accessing }
PaCasesMatrixTest >> option1: aString [ 
	option1 := aString
]

{ #category : #accessing }
PaCasesMatrixTest >> option2: anInteger [ 
	option2 := anInteger
]

{ #category : #tests }
PaCasesMatrixTest >> testOptions [

	self assert: option1 isString.
	self assert: option2 isInteger
]
