lookup
resolutionFor: aResolutionTarget
	
	(self resolvesTarget: aResolutionTarget)
		ifTrue: [ ^ self ].
	
	^ self allSubResolutions detect: [ :any | any resolvesTarget: aResolutionTarget ]