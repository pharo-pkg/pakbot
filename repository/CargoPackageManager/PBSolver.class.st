"
This solver is in charge of the dependencies resolution.
It goes through all transitive dependencies and tries to find a solution matching all specifications / requirements. If a package is alaready present in the installed package list, then the package is skipped for the resolution.
"
Class {
	#name : #PBSolver,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #solving }
PBSolver >> checkConflictsOf: resolvedProject [
	| dependencies |
	dependencies := resolvedProject allResolvedDependencies.
	dependencies
		do: [ :each | 
			each
				checkConflictsWithDependencies: dependencies;
				checkConflictsWithRegistry: self registry ]
]

{ #category : #solving }
PBSolver >> registry [

	^ registry
]

{ #category : #accessing }
PBSolver >> registry: aRegistry [ 
	registry := aRegistry
]

{ #category : #solving }
PBSolver >> solveProject: aProject [
	| resolvedProject |

	resolvedProject := PBResolvedProject onProject: aProject.
	aProject dependencies
		do: [ :each | 
			resolvedProject addResolvedDependency:
					(PBResolvedDependency
						onDependency: each
						resolution: (self solveProject: (each resolveInSolver: self))) ].
	self checkConflictsOf: resolvedProject.
	^ resolvedProject
]
