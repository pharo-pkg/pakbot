"
Strategy used to solve a dependency on a virtual package, i.e. which package to choose from all the possibly different packages  (and their package versions available).
See subclasses for available strategies.
"
Class {
	#name : #CGOVirtualPackageResolutionStrategy,
	#superclass : #Object,
	#category : 'CargoPackageManager-SolverStrategies'
}

{ #category : #solving }
CGOVirtualPackageResolutionStrategy >> solve: aDependency candidates: aListOfPackageVersionReferences [
	self subclassResponsibility
]
