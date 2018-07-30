Class {
	#name : #PaMatrixExampleTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'option1',
		'option2'
	],
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #private }
PaMatrixExampleTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelectors: #option1 addOptions: #(a b c);
		forSelectors: #option2 addOptions: {[1].[2].[3]};
		yourself.
]

{ #category : #accessing }
PaMatrixExampleTest >> option1: aString [ 
	option1 := aString
]

{ #category : #accessing }
PaMatrixExampleTest >> option2: anInteger [ 
	option2 := anInteger
]
