tests
testUpdateParts
	ongoingPkg manifest class compile: 'parts ^ #( #A #B )'.
	ongoingPkg updatePart: (#B -> #('=1.0')) asPackageDependency.
	self
		assert: ongoingPkg manifest parts
		equals: { #A . #B -> #('=1.0.0') }