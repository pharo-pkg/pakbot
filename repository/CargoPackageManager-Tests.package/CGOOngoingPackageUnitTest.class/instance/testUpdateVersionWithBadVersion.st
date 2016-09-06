tests-updating
testUpdateVersionWithBadVersion
	ongoingPkg manifest class compile: 'version ^ ''0.1.0-dev'''.
	self 
		should: [ ongoingPkg updateVersionWith: 'bla' ]
		raise: SemanticVersionFormatError