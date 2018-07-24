"
Constraint on a fixed dependency version of the targeted package.
"
Class {
	#name : #CGOFixedVersionConstraint,
	#superclass : #CGODependencyConstraint,
	#instVars : [
		'version'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #'instance creation' }
CGOFixedVersionConstraint class >> with: aStringOrSemanticVersion [ 
	^ self new
		initializeWith: aStringOrSemanticVersion asSemanticVersion;
		yourself.
]

{ #category : #comparing }
CGOFixedVersionConstraint >> = other [
	(self class = other class) ifFalse: [ ^false ].
	(self version = other version) ifFalse: [ ^false ].
	^true.
]

{ #category : #comparing }
CGOFixedVersionConstraint >> hash [
	^ self printString hash
]

{ #category : #initialization }
CGOFixedVersionConstraint >> initializeWith: aSemanticVersion [
	version := aSemanticVersion
]

{ #category : #testing }
CGOFixedVersionConstraint >> isCompatibleWith: aSemanticVersion [ 
	
	^ version = aSemanticVersion 
]

{ #category : #testing }
CGOFixedVersionConstraint >> isFixed [

	^ true
]

{ #category : #merging }
CGOFixedVersionConstraint >> merge: aDependencyConstraint [
	^ aDependencyConstraint mergeFixedVersionConstraint: self.
]

{ #category : #merging }
CGOFixedVersionConstraint >> mergeFixedVersionConstraint: aFixedVersionConstraint [
	^ (self version = aFixedVersionConstraint version)
		ifTrue: [ self ]
		ifFalse: [ self signalDependencyConflictWith: aFixedVersionConstraint ]
]

{ #category : #printing }
CGOFixedVersionConstraint >> printOn: aStream [

	aStream nextPutAll: version printString 
]

{ #category : #accessing }
CGOFixedVersionConstraint >> version [
	^ version
]
