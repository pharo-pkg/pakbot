Class {
	#name : #CGOSolverSeasideTest,
	#superclass : #RepositoryBasedTest,
	#instVars : [
		'solver'
	],
	#category : #'CargoPackageManager-FailingTests-Solver'
}

{ #category : #running }
CGOSolverSeasideTest >> setUp [
	super setUp.
	solver := PBSolver new
		repositories: { repository };
		yourself.
	Cargo platformAttributes: #(#squeakCommon #pharo #'pharo4.x' #'pharo4.0.x').
]

{ #category : #running }
CGOSolverSeasideTest >> tearDown [
	super tearDown.
	Cargo platformAttributes: nil
]

{ #category : #'tests - packages' }
CGOSolverSeasideTest >> testCanSolvePackageWithManyCompatibleConstraints [
	| testPackage dependency version resolution |
	
	testPackage := #'Seaside-Core'.
	version := '3.1' asSemanticVersion.					
	dependency := PBPackageDependency
						on: testPackage
						for: nil
						withConstraints: { PBFixedVersionConstraint with: version . 
							PBFixedVersionConstraint with: '3.1.0' asSemanticVersion }.

	resolution := solver solveDependency: dependency.
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: version
]

{ #category : #'tests - packages' }
CGOSolverSeasideTest >> testCanSolvePackageWithSpecifiedVersion [
	| testPackage dependency  version resolution |
	testPackage := #'JQuery-Core'.
	version := '3.1' asSemanticVersion.
	dependency := PBPackageDependency 
		on: testPackage 
		for: nil
		withConstraints: {(PBFixedVersionConstraint with: version)}.
	solver addConstraint: (PBFixedVersionConstraint with: version) on: testPackage.
	
	resolution := solver solveDependency: dependency.
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: version
]

{ #category : #'tests - packages' }
CGOSolverSeasideTest >> testCanSolvePackageWithoutSpecifiedVersion [
	| testPackage dependency resolution |
	
	testPackage := #'JQuery-Core'.
	dependency := PBPackageDependency 
		on: testPackage
		for: nil
		withConstraints: #().
	
	resolution := solver solveDependency: dependency.
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: '3.1.0' asSemanticVersion
]

{ #category : #'tests - virtual packages' }
CGOSolverSeasideTest >> testCanSolveVirtualPackageWithSpecifiedVersion [
	| testPackage version dependency resolution packageVersion |
	
	testPackage := #'Seaside-Canvas-Platform'.
	version := '1.0' asSemanticVersion.					
	dependency := PBPackageDependency
						on: testPackage
						for: nil
						withConstraints: { PBFixedVersionConstraint with: version }.

	resolution := solver solveDependency: dependency.
	packageVersion := (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion.
	
	self
		assert: packageVersion packageName
		equals: 'Seaside-Pharo-Canvas'.
	self
		assert: packageVersion version
		equals: '3.1' asSemanticVersion

]

{ #category : #'tests - virtual packages' }
CGOSolverSeasideTest >> testCanSolveVirtualPackageWithoutSpecifiedVersion [
	| testPackage dependency resolution packageVersion |
	
	testPackage := #'Seaside-Continuation-Platform'.
	dependency := PBPackageDependency
						on: testPackage
						for: nil
						withConstraints: #().

	resolution := solver solveDependency: dependency.
	packageVersion := (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion.
	
	self
		assert: packageVersion packageName
		equals: 'Seaside-Pharo-Continuation'.
	self
		assert: packageVersion version
		equals: '3.1' asSemanticVersion
]

{ #category : #tests }
CGOSolverSeasideTest >> testDefaultVersionIsAddedToConstraintsWhenNoConstraintAreSpecified [
	| resolution testPackage |
	testPackage := #'Seaside-Pharo-Flow'.
	
	resolution := solver solveDependency: (PBPackageDependency on: testPackage for: nil).
	
	self 
		assert: (resolution ongoingPackageResolutionFor: testPackage) resolvedProjectVersion version
		equals: '3.1.0' asSemanticVersion

	
	
]

{ #category : #tests }
CGOSolverSeasideTest >> testSolvePackageWithNonFixedConstraintDependencyRaisesUnresolvedDependency [
	| testPackage dependency |
	testPackage := #'JQuery-Core'.
	dependency := PBPackageDependency 
		on: testPackage 
		for: nil
		withConstraints: { PBRangeVersionsConstraint between: '2.1' and: '2.4' }.
	
	self 
		should: [ solver solveDependency: dependency ]
		raise: PBUnresolvedDependency.
]

{ #category : #'tests - packages' }
CGOSolverSeasideTest >> testSolvingADependencyWithATransitiveDependencySolvesBothDependencies [
	| dependencyToSolve resolution |
	dependencyToSolve := PBPackageDependency 
								on: 'Seaside-Flow-Platform'
								for: nil
								withConstraints: { PBFixedVersionConstraint with: '1' }.
	
	resolution := solver solveDependency: dependencyToSolve.

	self 
		assert: resolution resolvedVersions size 
		equals: 2
]

{ #category : #'tests - virtual packages' }
CGOSolverSeasideTest >> testSolvingAVirtualPackageProvidedByMoreThanOnePackageRaisesUnresolvedDependency [
	| dependency |
	
	dependency := PBPackageDependency
						on: #'Seaside-Canvas-Platform'
						for: nil
						withConstraints: #().
	SeasidePharo30CanvasSpec new buildPackage save.

	self 	
		should: [ solver solveDependency: dependency  ]
		raise: PBUnresolvedDependency
		withExceptionDo: [ :exception |
			self assert: exception candidates notNil.
			self assert: exception candidates size equals: 2 ]
	
]

{ #category : #'tests - virtual packages' }
CGOSolverSeasideTest >> testSolvingAVirtualPackageProvidedByNoPackageRaisesUnresolvedDependency [
	| dependency |
	
	dependency := PBPackageDependency
						on: #'Seaside-Canvas-Platform'
						for: nil
						withConstraints: { PBFixedVersionConstraint with: '99.5' }.

	self 	
		should: [ solver solveDependency: dependency  ]
		raise: PBUnresolvedDependency.
		
	
]
