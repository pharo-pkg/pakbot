Extension { #name : #PBAbstractDependencyState }

{ #category : #'*CargoPackageManager-UI' }
PBAbstractDependencyState >> nodesInResolutionTree [
	
	^ dependency subresolutions
]
