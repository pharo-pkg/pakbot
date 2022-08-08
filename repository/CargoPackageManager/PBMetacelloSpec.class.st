"
I represent a Metacello specification (spec:with:).
I'm used to store information during the visit of a Baseline by `PBBaselineVisitor`.
Once the visit step is finished, `PBBaselineVisitor` uses me to generate the appropriate Pakbot metadata.
"
Class {
	#name : #PBMetacelloSpec,
	#superclass : #Object,
	#instVars : [
		'requirements',
		'name',
		'attributes'
	],
	#category : #'CargoPackageManager-Metacello'
}

{ #category : #accessing }
PBMetacelloSpec >> addRequirements: aRequirementList [
	aRequirementList isString 
		ifTrue: [ requirements add: aRequirementList ]
		ifFalse: [ requirements addAll: aRequirementList ]
	
]

{ #category : #accessing }
PBMetacelloSpec >> attributes [
	^ attributes
]

{ #category : #accessing }
PBMetacelloSpec >> attributes: anAttributeOrListOfAttributes [
	attributes := anAttributeOrListOfAttributes isString 
		ifTrue: [ Array with: anAttributeOrListOfAttributes ]
		ifFalse: [ anAttributeOrListOfAttributes copy ]
]

{ #category : #initialization }
PBMetacelloSpec >> initialize [ 
	requirements := OrderedCollection new. 
]

{ #category : #testing }
PBMetacelloSpec >> isPackageSpec [
	
	self subclassResponsibility
]

{ #category : #accessing }
PBMetacelloSpec >> name [
	^ name
]

{ #category : #accessing }
PBMetacelloSpec >> name: aName [
	name := aName
]
