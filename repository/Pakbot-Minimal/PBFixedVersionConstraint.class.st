"
Constraint on a fixed dependency version of the targeted package.
"
Class {
	#name : #PBFixedVersionConstraint,
	#superclass : #PBDependencyConstraint,
	#instVars : [
		'version'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #'instance creation' }
PBFixedVersionConstraint class >> with: aStringOrSemanticVersion [ 
	^ self new
		initializeWith: aStringOrSemanticVersion asSemanticVersion;
		yourself.
]

{ #category : #comparing }
PBFixedVersionConstraint >> = other [
	(self class = other class) ifFalse: [ ^false ].
	(self version = other version) ifFalse: [ ^false ].
	^true.
]

{ #category : #comparing }
PBFixedVersionConstraint >> hash [
	^ self printString hash
]

{ #category : #initialization }
PBFixedVersionConstraint >> initializeWith: aSemanticVersion [
	version := aSemanticVersion
]

{ #category : #testing }
PBFixedVersionConstraint >> isCompatibleWith: aSemanticVersion [ 
	
	^ version = aSemanticVersion 
]

{ #category : #testing }
PBFixedVersionConstraint >> isFixed [

	^ true
]

{ #category : #merging }
PBFixedVersionConstraint >> merge: aDependencyConstraint [
	^ aDependencyConstraint mergeFixedVersionConstraint: self.
]

{ #category : #merging }
PBFixedVersionConstraint >> mergeFixedVersionConstraint: aFixedVersionConstraint [
	^ (self version = aFixedVersionConstraint version)
		ifTrue: [ self ]
		ifFalse: [ self signalDependencyConflictWith: aFixedVersionConstraint ]
]

{ #category : #printing }
PBFixedVersionConstraint >> printOn: aStream [

	aStream nextPutAll: version printString 
]

{ #category : #accessing }
PBFixedVersionConstraint >> version [
	^ version
]
