lookup
resolutionFor: aResolutionTarget
	
	(aResolutionTarget isResolvedBy: self)
		ifTrue: [ ^ self ].
	
	^ self allSubResolutions detect: [ :any | aResolutionTarget isResolvedBy: any ]