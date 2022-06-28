Extension { #name : #PBResolvedConflictDependencyState }

{ #category : #'*Pakbot-Browser' }
PBResolvedConflictDependencyState >> nodesInResolutionTree [
	^ { PBResolvedConflictTreeItem forOriginal: dependency originalResolution.
	    PBResolvedConflictTreeItem forResolution: resolution }
]
