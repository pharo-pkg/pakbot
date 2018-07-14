"
I handle REST requests for /packages/{1}/{2}/loadlist
ex: /packages/foo/1.2/loadlist

I return the load list (ordered list of packages to load) for the specified package version.
"
Class {
	#name : #CGORepositoryPackageLoadInstructionsHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryPackageLoadInstructionsHandler class >> pattern [
	^ #( 'packages' '*' '*' 'loadinstructions')
]

{ #category : #public }
CGORepositoryPackageLoadInstructionsHandler >> get [
	| dependency resolution sorter |
	dependency := CGOPackageDependency
						on: (CGOPackage named: variables first)
						for: nil
						withConstraints: { CGOFixedVersionConstraint with: variables second }.
	resolution := CGOSolver new solveDependency: dependency.
	sorter := CGOLoadInstructionsBuilder new
					resolution: resolution;
					yourself.
	^ self stonResponse: sorter loadInstructions
]
