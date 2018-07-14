"
This strategy is used to ask the user which package to load when  many packages  implement the required virtual package and fullfill all requirements.

ex:
	A@1.1 provides  MAIL@1.0
	B@2.0 provides  MAIL@1.0
"
Class {
	#name : #CGOInteractiveVirtualPackageResolutionStrategy,
	#superclass : #CGOVirtualPackageResolutionStrategy,
	#category : 'CargoPackageManager-SolverStrategies'
}

{ #category : #solving }
CGOInteractiveVirtualPackageResolutionStrategy >> solve: aDependency candidates: aListOfPackageVersionReferences [
	| candidates |
	
	candidates := (aListOfPackageVersionReferences collect: #asPackageVersionReference) 
							groupedBy: #packageName.	
	
	^ (candidates size = 1)
		ifTrue: [ (candidates values first detectMax: #versionNumber) asString ]
		ifFalse: [ CGOUnresolvedDependency 
			package: aDependency targetedPackage 
			candidates: (candidates values collect: [ :each | each detectMax: #versionNumber ]) ]
]
