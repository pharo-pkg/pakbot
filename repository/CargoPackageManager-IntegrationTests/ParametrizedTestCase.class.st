Class {
	#name : #ParametrizedTestCase,
	#superclass : #TestCase,
	#instVars : [
		'parametersToUse'
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
		internalSuite tests do: [ :aTest | aTest parametersToUse: expandedParameters ].
		suite addTests: internalSuite tests.
	].

	^ suite
]

{ #category : #private }
ParametrizedTestCase class >> isAbstract [
	^ self name = #ParametrizedTestCase 
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

{ #category : #accessing }
ParametrizedTestCase >> parametersToUse [
	^ parametersToUse ifNil: [#()]
]

{ #category : #accessing }
ParametrizedTestCase >> parametersToUse: anObject [
	parametersToUse := anObject
]

{ #category : #printing }
ParametrizedTestCase >> printOn: aStream [

	super printOn: aStream.
	parametersToUse ifNotNil: [ parametersToUse printElementsOn: aStream.]
	
]

{ #category : #private }
ParametrizedTestCase >> setUp [
	super setUp.
	self parametersToUse do: [ :aParameter | aParameter applyTo: self ].
	
	"If I am executed without calling buildSuite in the class. I will use the first set of options.
	This is a workaround to work when running from Calypso"
	(self parametersToUse isEmpty and: [self class testParameters isNotEmpty]) 
		ifTrue: [ 
				self class 
						testParameters expandMatrix first 
						do: [ :aParameter | aParameter applyTo: self ] ]
]
