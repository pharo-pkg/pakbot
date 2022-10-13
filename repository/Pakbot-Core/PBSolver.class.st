"
This solver is in charge of the dependencies resolution.
It goes through all transitive dependencies and tries to find a solution matching all specifications / requirements. If a package is alaready present in the installed package list, then the package is skipped for the resolution.
"
Class {
	#name : #PBSolver,
	#superclass : #Object,
	#instVars : [
		'registry',
		'platformAttributes'
	],
	#category : #'Pakbot-Core-Solver'
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

{ #category : #accessing }
PBSolver >> platformAttributes [
	^ platformAttributes ifNil: [ PBPlatformAttributes new ]
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
PBSolver >> solveDependenciesOf: aPBLodoableElement in: aPBResolvedProject [

	aPBLodoableElement dependencies
		select: [ :dep | dep satisfyPlatformRequirements: self platformAttributes ]
		thenDo: [ :dep | dep resolveIn: aPBResolvedProject solver: self ].

	self checkConflictsOf: aPBResolvedProject.
	^ aPBResolvedProject
]

{ #category : #solving }
PBSolver >> solvePackage: aPBPackage [ 
	| resolvedProject |

	resolvedProject := PBResolvedProject onProject: aPBPackage project.
	resolvedProject addToLoadList: aPBPackage name.

	^ self solveDependenciesOf: aPBPackage in: resolvedProject
]

{ #category : #solving }
PBSolver >> solveProject: aProject [

	^ self solveProject: aProject loads: #()
]

{ #category : #solving }
PBSolver >> solveProject: aProject loads: aListOfPackageNameToLoad [

	| resolvedProject |
	resolvedProject := PBResolvedProject onProject: aProject.
	aListOfPackageNameToLoad
		ifNotEmpty: [ :packages | resolvedProject addAllToLoadList: packages ].

	^ self solveDependenciesOf: aProject in: resolvedProject
]
