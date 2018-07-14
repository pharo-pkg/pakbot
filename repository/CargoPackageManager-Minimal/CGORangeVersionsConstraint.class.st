"
A RangeVersionsUpdatePolicy updates a depedency for all versions included into the specified version range.

examples: 
	>1.5 and <2.1
"
Class {
	#name : #CGORangeVersionsConstraint,
	#superclass : #CGODependencyConstraint,
	#instVars : [
		'minVersion',
		'maxVersion'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #'instance creation' }
CGORangeVersionsConstraint class >> between: lowerSemanticVersion and: upperSemanticVersion [
	^ CGORangeVersionsConstraint new 
		initializeWithRangeBetween: lowerSemanticVersion and: upperSemanticVersion;
		yourself.
]

{ #category : #initializing }
CGORangeVersionsConstraint >> initializeWithRangeBetween: lowerSemanticVersion and: upperSemanticVersion [
	super initialize.
	minVersion := lowerSemanticVersion asSemanticVersion.
	maxVersion := upperSemanticVersion asSemanticVersion
]

{ #category : #accessing }
CGORangeVersionsConstraint >> maxVersion [
	^ maxVersion
]

{ #category : #merging }
CGORangeVersionsConstraint >> mergeFixedVersionConstraint: aFixedVersionConstraint [
	self flag: 'TODO'
]

{ #category : #accessing }
CGORangeVersionsConstraint >> minVersion [
	^ minVersion
]
