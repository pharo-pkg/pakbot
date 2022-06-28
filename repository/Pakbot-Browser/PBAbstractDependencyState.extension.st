Extension { #name : #PBAbstractDependencyState }

{ #category : #'*Pakbot-Browser' }
PBAbstractDependencyState >> nodesInResolutionTree [
	
	^ dependency subresolutions
]
