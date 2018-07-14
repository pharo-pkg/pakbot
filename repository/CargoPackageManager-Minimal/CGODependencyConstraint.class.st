"
An UpdatePolicy is an update strategy for packages update.

"
Class {
	#name : #CGODependencyConstraint,
	#superclass : #Object,
	#classInstVars : [
		'package'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #'instance creation' }
CGODependencyConstraint class >> fromString: aString [
	| constraintString |
	
	constraintString := aString trim.
	(constraintString first = $=)
		ifTrue: [ ^ CGOFixedVersionConstraint with: (SemanticVersion fromString: constraintString allButFirst ) ]
		ifFalse: [ CGODependencyConstraintFormatError signal ]
]

{ #category : #testing }
CGODependencyConstraint >> isCompatibleWith: aSemanticVersion [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
CGODependencyConstraint >> isFixed [
	
	^ false
]

{ #category : #merging }
CGODependencyConstraint >> merge: aDependencyConstraint [
	self shouldBeImplemented
]

{ #category : #merging }
CGODependencyConstraint >> mergeAll: aDependencyConstraintsList [
	^ aDependencyConstraintsList 
		ifEmpty: [ self asOrderedCollection ]
		ifNotEmpty: [ aDependencyConstraintsList collect: [ :aConstraint | aConstraint merge: self ] ]
]

{ #category : #merging }
CGODependencyConstraint >> mergeFixedVersionConstraint: aFixedVersionConstraint [
	self shouldBeImplemented
]

{ #category : #signaling }
CGODependencyConstraint >> signalDependencyConflictWith: aPolicy [
	| error |
	
	error := CGODependencyConflictError new.
	error
		policy1: self;
		policy2: aPolicy; 
		signal
]
