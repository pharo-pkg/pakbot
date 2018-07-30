Class {
	#name : #ParametrizedTestMatrix,
	#superclass : #Object,
	#instVars : [
		'selector',
		'options',
		'cases'
	],
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #cases }
ParametrizedTestMatrix >> addCase: aCollection [

	^ cases add: (aCollection asDictionary associations
		collect: [ :assoc | 
			ParametrizedTestExpandedParameter new
				selector: assoc key;
				valuable: assoc value;
				yourself ]
		as: Array)
]

{ #category : #generating }
ParametrizedTestMatrix >> combinationsOf: aCollection [ 
	
	| first expandedParameters inner |
	aCollection ifEmpty: [ ^ #() ].
	
	first := aCollection first.
	expandedParameters := first value collect: [ :each | ParametrizedTestExpandedParameter new selector: first key; valuable: each].
	
	inner := self combinationsOf: aCollection allButFirst.
	inner ifEmpty: [ ^ expandedParameters collect: [ :each | { each } ] ].
	
	^ expandedParameters flatCollect: [ :aParameter | inner collect:[:aCase | {aParameter} , aCase ] ]
]

{ #category : #expanding }
ParametrizedTestMatrix >> expandMatrix [
	
	| combinations |
	combinations := self combinationsOf: options associations.
	combinations ifEmpty: [ ^ cases ].
	cases ifEmpty: [ ^ combinations ].
	
	^ combinations flatCollect: [ :aCase | cases collect: [ :each | aCase , each ] ]
]

{ #category : #addingOptions }
ParametrizedTestMatrix >> forSelector: aSelector addOptions: someOptions [

	options at: aSelector put: someOptions
]

{ #category : #initialization }
ParametrizedTestMatrix >> initialize [
	super initialize.
	options := Dictionary new.
	cases := OrderedCollection new
]

{ #category : #testing }
ParametrizedTestMatrix >> isEmpty [
	
	^ options isEmpty and: [ cases isEmpty ]
]

{ #category : #testing }
ParametrizedTestMatrix >> isNotEmpty [
	
	^ self isEmpty not
]

{ #category : #accessing }
ParametrizedTestMatrix >> options [
	^ options
]

{ #category : #accessing }
ParametrizedTestMatrix >> selector [
	^ selector
]

{ #category : #accessing }
ParametrizedTestMatrix >> selector: aString [ 
	selector := aString
]

{ #category : #accessing }
ParametrizedTestMatrix >> values: aCollection [ 
	options := aCollection collect:[ :aValue | 
		ParametrizedTestExpandedParameter new 
			parameter: self; 
			valuable: aValue;
			yourself]
]
