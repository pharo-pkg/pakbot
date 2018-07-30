Class {
	#name : #PaCombinedMatrixExampleTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'option1',
		'option2',
		'option3'
	],
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #'building suites' }
PaCombinedMatrixExampleTest class >> testParameters [

	^ ParametrizedTestMatrix new
		addCase: { #option1 -> 'a'. #option2 -> 1};
		addCase: { #option1 -> 'b'. #option2 -> 2};		
		addCase: { #option1 -> 'c'. #option2 -> 3};		
		forSelectors: #option3 addOptions: #(a b);
		yourself.
]

{ #category : #accessing }
PaCombinedMatrixExampleTest >> option1: aString [ 
	option1 := aString
]

{ #category : #accessing }
PaCombinedMatrixExampleTest >> option2: anInteger [ 
	option2 := anInteger
]

{ #category : #accessing }
PaCombinedMatrixExampleTest >> option3: aString [ 
	option3 := aString
]
