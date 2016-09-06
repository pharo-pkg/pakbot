tests-updating
testUpdateDependencyWithSymbol
	ongoingPkg manifest class compile: 'dependencies ^ { #A -> #(''=0.2'') }'.
	ongoingPkg updateDependency: #A asPackageDependency.
	self 
		assert: ongoingPkg manifest dependencies
		equals: #( #A )