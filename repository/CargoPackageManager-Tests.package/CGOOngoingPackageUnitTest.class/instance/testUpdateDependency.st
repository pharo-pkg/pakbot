tests-updating
testUpdateDependency
	ongoingPkg manifest class compile: 'dependencies ^ { #A -> #(''=0.2'') }'.
	ongoingPkg updateDependency: (#A -> #('=1.0')) asPackageDependency.
	self 
		assert: ongoingPkg manifest dependencies
		equals: {(#A -> #('=1.0.0'))}