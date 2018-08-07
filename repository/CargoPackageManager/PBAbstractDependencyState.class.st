Class {
	#name : #PBAbstractDependencyState,
	#superclass : #Object,
	#instVars : [
		'dependency'
	],
	#category : #'CargoPackageManager-Solver-Conflicts'
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
