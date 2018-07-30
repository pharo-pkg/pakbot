Class {
	#name : #PaSuiteTest,
	#superclass : #ParametrizedTestCase,
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #tests }
PaSuiteTest >> testCasesHasTheCorrectNumberOfTests [

	| suite |
	suite := PaCasesMatrixTest buildSuite.
	self assert: suite tests size equals: 3
]

{ #category : #tests }
PaSuiteTest >> testCombinedHasTheCorrectNumberOfTests [

	| suite |
	suite := PaCombinedMatrixExampleTest buildSuite.
	self assert: suite tests size equals: 6
]

{ #category : #tests }
PaSuiteTest >> testMatrixExampleHasTheCorrectNumberOfTests [

	| suite |
	suite := PaMatrixExampleTest buildSuite.
	self assert: suite tests size equals: 9
]
