"
This solver is in charge of the dependencies resolution.
It goes through all transitive dependencies and tries to find a solution matching all specifications / requirements. If a package is alaready present in the installed package list, then the package is skipped for the resolution.
"
Class {
	#name : #CGOSolver,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : 'CargoPackageManager-Solver'
}

{ #category : #solving }
CGOSolver >> registry [

	^ registry
]

{ #category : #accessing }
CGOSolver >> registry: aRegistry [ 
	registry := aRegistry
]

{ #category : #solving }
CGOSolver >> solveProject: aProject [
	
	| resolvedProject dependencies |
	resolvedProject := PBResolvedProject onProject: aProject.
	
	"Solve the project"
	aProject dependencies do: [ :each |
		resolvedProject addResolvedDependency: (PBResolvedDependency
			onDependency: each
			resolution: (self solveProject: (each resolveInSolver: self))) ].
	
	"Check conflicts"
	dependencies := resolvedProject allResolvedDependencies.
	dependencies do: [ :each | 
		each
			checkConflictsWithDependencies: dependencies;
			checkConflictsWithRegistry: self registry ].
	^ resolvedProject
]
