"
I represent the state of a dependency regarding the currently installed project and newly projects to install:
- is the dependency conflicting with another project installation or dependency?
- is the dependency not conflicting with anything?
- was the dependency conflicting and then manually resolved by the user?
"
Class {
	#name : #PBAbstractDependencyState,
	#superclass : #Object,
	#instVars : [
		'dependency'
	],
	#category : #'Pakbot-Core-Solver-Conflicts'
}

{ #category : #'instance-creation' }
PBAbstractDependencyState class >> onDependency: aDependency [

	^ self new
		dependency: aDependency;
		yourself
]

{ #category : #accessing }
PBAbstractDependencyState >> dependency: aCGOResolvedDependency [ 
	dependency := aCGOResolvedDependency
]

{ #category : #accessing }
PBAbstractDependencyState >> isConflictingDependency [

	^ self subclassResponsibility
]

{ #category : #accessing }
PBAbstractDependencyState >> resolutionFor: aPBResolvedDependency [
 
	^ self subclassResponsibility
]
