"
A BleedingEdgeUpdatePolicy is used to specify that we should always take the latest version of the package targeted by the dependency.
"
Class {
	#name : #CGOBleedingEdgeResolutionStrategy,
	#superclass : #CGOPackageVersionResolutionStrategy,
	#category : 'CargoPackageManager-SolverStrategies'
}

{ #category : #printing }
CGOBleedingEdgeResolutionStrategy >> printOn: aStream [
	aStream nextPutAll: '#bleedingEdge'
]

{ #category : #solving }
CGOBleedingEdgeResolutionStrategy >> versionOf: aCGOPackageDependency in: aRepositoryList forEnvironment: platformAttributes [
	| candidates packageName |

	candidates := Set new.
	packageName := aCGOPackageDependency dependencyName.
	aRepositoryList 
		do: [ :repository | 
			[ candidates add: (repository latestVersionOfPackage: packageName suitableForEnvironment: platformAttributes) asPackageVersionReference ]
				on: CGOPackageNotFoundError
				do: [ "ignore" ] ].
	candidates ifEmpty: [ CGOPackageNotFoundError signal: packageName ].
	(candidates size = 1)
		ifTrue: [ ^ candidates anyOne ].
	candidates := candidates groupedBy: #packageName.
	(candidates size > 1)
		ifTrue: [ CGOUnresolvedDependency package: packageName candidates: candidates ].
	^ (candidates at: packageName) detectMax: [ :v | v ]
]
