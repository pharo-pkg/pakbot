private - displaying
ballonTextFor: aPart

	aPart isInstalled ifFalse: [ ^ 'The dependency is not installed in the system' ].
	^ nil