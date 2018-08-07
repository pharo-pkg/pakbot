Extension { #name : #PBResolvedConflictDependencyState }

{ #category : #'*CargoPackageManager-UI' }
PBResolvedConflictDependencyState >> hasToBeExpanded [
	
	^ true
]

{ #category : #'*CargoPackageManager-UI' }
PBResolvedConflictDependencyState >> nodesInResolutionTree [
	^ { PBResolvedConflictTreeItem forOriginal: dependency originalResolution.
	    PBResolvedConflictTreeItem forResolution: resolution }
]
