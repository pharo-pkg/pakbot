tests-updating
testUpdateVersionWith
	ongoingPkg manifest class compile: 'version ^ ''0.1.0-dev'''.
	ongoingPkg updateVersionWith: '1.0'.
	self 
		assert: ongoingPkg manifest version
		equals: '1.0'