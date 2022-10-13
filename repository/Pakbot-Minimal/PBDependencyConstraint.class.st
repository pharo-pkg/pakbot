"
An UpdatePolicy is an update strategy for packages update.

"
Class {
	#name : #PBDependencyConstraint,
	#superclass : #Object,
	#classInstVars : [
		'package'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #'instance creation' }
PBDependencyConstraint class >> fromString: aString [
	| constraintString |
	"It only supports fixed versions"
	constraintString := aString trim.
	(constraintString first = $=)
		ifTrue: [ constraintString := constraintString allButFirst ].
		
	^ PBFixedVersionConstraint with: (SemanticVersion fromString: constraintString )
]

{ #category : #'instance creation' }
PBDependencyConstraint class >> fromVersion: aStringOrVersion [

	aStringOrVersion isString ifTrue: [ ^ self fromString: aStringOrVersion ].
	^ PBFixedVersionConstraint with: aStringOrVersion
]

{ #category : #testing }
PBDependencyConstraint >> isCompatibleWith: aSemanticVersion [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
PBDependencyConstraint >> isFixed [
	
	^ false
]

{ #category : #merging }
PBDependencyConstraint >> merge: aDependencyConstraint [
	self shouldBeImplemented
]

{ #category : #merging }
PBDependencyConstraint >> mergeAll: aDependencyConstraintsList [
	^ aDependencyConstraintsList 
		ifEmpty: [ self asOrderedCollection ]
		ifNotEmpty: [ aDependencyConstraintsList collect: [ :aConstraint | aConstraint merge: self ] ]
]

{ #category : #merging }
PBDependencyConstraint >> mergeFixedVersionConstraint: aFixedVersionConstraint [
	self shouldBeImplemented
]

{ #category : #signaling }
PBDependencyConstraint >> signalDependencyConflictWith: aPolicy [
	| error |
	
	error := CGODependencyConflictError new.
	error
		policy1: self;
		policy2: aPolicy; 
		signal
]
