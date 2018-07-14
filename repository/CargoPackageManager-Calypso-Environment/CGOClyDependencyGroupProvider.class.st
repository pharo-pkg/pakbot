"
I'm a specific version of a PackageGroupProvider giving only a group of set of dependencies for the current project.
Content retrieval is assumed by CGOClyPackageDependencyGroup as it is actually the parent node of dependencies in the project tree.
"
Class {
	#name : #CGOClyDependencyGroupProvider,
	#superclass : #ClySingleClassGroupProvider,
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #'building groups' }
CGOClyDependencyGroupProvider >> createClassGroupFor: aClassQuery from: aClyPackageScope [ 
	^ClyClassGroup named: 'Dependencies' priority: 0 on: aClassQuery
]

{ #category : #'building groups' }
CGOClyDependencyGroupProvider >> createClassQueryFrom: aPackageScope [ 
	^ClyAllClasses sortedFrom: aPackageScope
]
