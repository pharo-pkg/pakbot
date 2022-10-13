"
A RangeVersionsUpdatePolicy updates a depedency for all versions included into the specified version range.

examples: 
	>1.5 and <2.1
"
Class {
	#name : #PBRangeVersionsConstraint,
	#superclass : #PBDependencyConstraint,
	#instVars : [
		'minVersion',
		'maxVersion'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #'instance creation' }
PBRangeVersionsConstraint class >> between: lowerSemanticVersion and: upperSemanticVersion [
	^ PBRangeVersionsConstraint new 
		initializeWithRangeBetween: lowerSemanticVersion and: upperSemanticVersion;
		yourself.
]

{ #category : #initializing }
PBRangeVersionsConstraint >> initializeWithRangeBetween: lowerSemanticVersion and: upperSemanticVersion [
	super initialize.
	minVersion := lowerSemanticVersion asSemanticVersion.
	maxVersion := upperSemanticVersion asSemanticVersion
]

{ #category : #accessing }
PBRangeVersionsConstraint >> maxVersion [
	^ maxVersion
]

{ #category : #merging }
PBRangeVersionsConstraint >> mergeFixedVersionConstraint: aFixedVersionConstraint [
	self flag: 'TODO'
]

{ #category : #accessing }
PBRangeVersionsConstraint >> minVersion [
	^ minVersion
]
