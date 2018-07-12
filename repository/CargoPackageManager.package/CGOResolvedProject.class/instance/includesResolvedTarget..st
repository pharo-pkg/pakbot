lookup
includesResolvedTarget: aResolutionTarget

	(self resolvesTarget: aResolutionTarget)
		ifTrue: [ ^ true ].

	^ self allSubResolutions anySatisfy: [ :any | 
		any resolvesTarget: aResolutionTarget ]