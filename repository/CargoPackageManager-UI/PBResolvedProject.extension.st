Extension { #name : #PBResolvedProject }

{ #category : #'*CargoPackageManager-UI' }
PBResolvedProject >> hasToBeExpanded [
	
	^ resolvedDependencies anySatisfy: [ :each | each hasToBeExpanded ]
]

{ #category : #'*CargoPackageManager-UI' }
PBResolvedProject >> nodesInResolutionTree [
	
	^ self subresolutions 
]
