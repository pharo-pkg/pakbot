Class {
	#name : #ParametrizedTestCase,
	#superclass : #TestCase,
	#instVars : [
		'testParameters'
	],
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #'building suites' }
ParametrizedTestCase class >> buildSuite [

	| expandedMatrix suite |
	
	expandedMatrix := self testParameters expandMatrix.

	expandedMatrix ifEmpty: [ ^ self buildSuiteFromSelectors].

	suite := self suiteClass named: self name.
	expandedMatrix do: [ :expandedParameters | |internalSuite|
		internalSuite := self buildSuiteFromSelectors.
		internalSuite tests do: [ :aTest | aTest testParameters: expandedParameters ].
		suite addTests: internalSuite tests.
	].

	^ suite
]

{ #category : #'building suites' }
ParametrizedTestCase class >> buildSuiteWithParameters: parameters expandedParameters: expandedParameters suiteName: suiteName [

	| suite param |
	parameters ifEmpty: [  
		suite := self buildSuiteFromSelectors.
		suite tests do: [ :test | test testParameters: expandedParameters ].
		^ suite.
	].

	suite := self suiteClass named: suiteName.
	param := parameters first.
	param options do: [ :expanded |
		suite addTest: (self
			buildSuiteWithParameters: parameters copyWithoutFirst
			expandedParameters: (expandedParameters copyWith: expanded)
			suiteName: suiteName, ' ', expanded suiteName)
	].

	^ suite
]

{ #category : #'building suites' }
ParametrizedTestCase class >> testParameters [

	^ ParametrizedTestMatrix new
]

{ #category : #private }
ParametrizedTestCase >> cleanUpInstanceVariables [
	| instanceVariablesNames |

	instanceVariablesNames := #('testSelector' 'testParameters').
	self class allInstVarNames
		do: [ :name | 
			(instanceVariablesNames includes: name)
				ifFalse: [ self instVarNamed: name put: nil ] ]
]

{ #category : #printing }
ParametrizedTestCase >> printOn: aStream [

	super printOn: aStream.
	testParameters ifNotNil: [ testParameters printElementsOn: aStream.]
	
]

{ #category : #private }
ParametrizedTestCase >> setUp [
	super setUp.
	self testParameters do: [ :aParameter | aParameter applyTo: self ]
]

{ #category : #accessing }
ParametrizedTestCase >> testParameters [
	^ testParameters ifNil: [#()]
]

{ #category : #accessing }
ParametrizedTestCase >> testParameters: anObject [
	testParameters := anObject
]
