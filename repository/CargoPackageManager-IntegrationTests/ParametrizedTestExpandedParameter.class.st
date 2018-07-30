Class {
	#name : #ParametrizedTestExpandedParameter,
	#superclass : #Object,
	#instVars : [
		'selector',
		'valuable'
	],
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #applying }
ParametrizedTestExpandedParameter >> applyTo: aTest [

	| anObject |
	anObject := self valuable isBlock
		ifTrue: [ self valuable cull: aTest ]
		ifFalse: [ self valuable ].

	aTest perform: selector asMutator with: anObject
]

{ #category : #printing }
ParametrizedTestExpandedParameter >> printOn: aStream [
	aStream print: (selector -> valuable)
]

{ #category : #accessing }
ParametrizedTestExpandedParameter >> selector [
	^ selector
]

{ #category : #accessing }
ParametrizedTestExpandedParameter >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
ParametrizedTestExpandedParameter >> suiteName [
	^ selector , ' -> ' , valuable printString
]

{ #category : #accessing }
ParametrizedTestExpandedParameter >> valuable [
	^ valuable
]

{ #category : #accessing }
ParametrizedTestExpandedParameter >> valuable: aValuable [ 
	valuable := aValuable
]
