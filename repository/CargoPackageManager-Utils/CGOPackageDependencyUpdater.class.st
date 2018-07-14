"
Will update, if needed, the #dependencies method of package manifest with :
	* static dependencies as computed by the Dependency Analyzer
	* manually resolved dependencies (warning if not up-to-date)
	* and take care to remove ignored dependencies

example: 
	self updateDependenciesOf: { ManifestFoo }.

	self updateTransitiveDependenciesOf:  (AssemblyManifest packageNamed: 'Pharo-Kernel')
"
Class {
	#name : #CGOPackageDependencyUpdater,
	#superclass : #Object,
	#instVars : [
		'manifests',
		'visited'
	],
	#category : 'CargoPackageManager-Utils'
}

{ #category : #accessing }
CGOPackageDependencyUpdater class >> allCurrentDependenciesOf: aPackageName [
	"List dependencies and transitive dependencies of the given package name"
	^ self allCurrentDependenciesOfManifest: aPackageName packageManifest
]

{ #category : #accessing }
CGOPackageDependencyUpdater class >> allCurrentDependenciesOfManifest: aManifest [
	"List dependencies and transitive dependencies of the given manifest by using the information  present in the manifest #dependencies method (could be outdated)."
	^ (self manifestsForAllCurrentDependenciesOfManifest: aManifest)
			collect: #packageName
]

{ #category : #private }
CGOPackageDependencyUpdater class >> manifestsForAllCurrentDependenciesOfManifest: aManifest [
	"List dependencies and transitive dependencies of the given manifest by using the information  present in the manifest #dependencies method (could be outdated)."
	| iterator deps |
	
	iterator := (BFSIterator 
		on: aManifest
		nextBlock: 
			[ :manifest |
			manifest asOngoingPackageVersion dependencies
				reject: [ :each | manifest ignoredDependencies includes: each targetedPackage ]
				thenCollect: [ :each | each targetedPackage packageManifest ] ]).
	
	deps := Set new.
	[ iterator hasNext ] whileTrue: [ deps add: iterator next ].
	^ (deps reject: [ :manifest | manifest asOngoingPackageVersion isAssembly ]) 
		asArray
]

{ #category : #accessing }
CGOPackageDependencyUpdater class >> packageUnitsOf: anAssembly [
	"List package units of the given assembly"
	^ (anAssembly asOngoingPackageVersion packageUnits collect: #packageManifest) 
			collect: #packageName 
			as: Array
]

{ #category : #updating }
CGOPackageDependencyUpdater class >> updateDependenciesOf: aListOfPackageManifest [
	^ self basicNew 
		initializeWith: aListOfPackageManifest;
		updateDependencies
]

{ #category : #updating }
CGOPackageDependencyUpdater class >> updateTransitiveDependenciesOf: anAssemblyManifest [
	self updateDependenciesOf: 
		(self manifestsForAllCurrentDependenciesOfManifest: anAssemblyManifest)
]

{ #category : #computing }
CGOPackageDependencyUpdater >> dependenciesOf: manifest [
	^ ((Set withAll: (self staticDependenciesOf: manifest)) , manifest manuallyResolvedDependencies)
			reject: [ :each | manifest ignoredDependencies includes: each ]
]

{ #category : #initialization }
CGOPackageDependencyUpdater >> initializeWith: aListOfPackageManifest [ 
	manifests := aListOfPackageManifest.
	visited := SharedQueue new.
]

{ #category : #computing }
CGOPackageDependencyUpdater >> staticAnalysisFor: packageName [
	"return the resul of the static analysis (package dependencies) on packageName."
	
	^ [ DAMessageSendAnalyzer on: packageName ]
		on: PotentialOutDatedDependencyWarning
		do: [:ex | ex resume ]
]

{ #category : #computing }
CGOPackageDependencyUpdater >> staticDependenciesOf: manifest [
	^ (self staticAnalysisFor: manifest packageName) packageStaticDependencies
]

{ #category : #updating }
CGOPackageDependencyUpdater >> updateDependencies [
	manifests do: [ :manifest | self updateDependenciesOf: manifest ]
]

{ #category : #updating }
CGOPackageDependencyUpdater >> updateDependenciesOf: manifest [
	| currentDependencies manifestDependencies extraDependencies |

	visited nextPut: manifest.
	currentDependencies := (self dependenciesOf: manifest) sorted.
	manifestDependencies := manifest dependencies.
	currentDependencies = manifestDependencies
		ifFalse: [ 
			manifest asOngoingPackageVersion updateManifestDependencies: (currentDependencies collect: [ :each | CGOPackageDependency on: each]).
			"If we find new dependencies, we also need to update the manifest of these new dependencies (#dependencies metatdat could be outdated)"
			extraDependencies := ((currentDependencies difference: manifestDependencies) collect: #packageManifest) 
					difference: visited.
			extraDependencies do: [ :extraManifest | self updateDependenciesOf: extraManifest ] ].

]
