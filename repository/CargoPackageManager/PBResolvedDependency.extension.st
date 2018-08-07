Extension { #name : #PBResolvedDependency }

{ #category : #'*CargoPackageManager' }
PBResolvedDependency >> nodesInResolutionTree [
	
	^ dependencyState nodesInResolutionTree
]
