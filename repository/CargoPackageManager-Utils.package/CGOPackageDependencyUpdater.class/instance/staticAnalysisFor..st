computing
staticAnalysisFor: packageName
	"return the resul of the static analysis (package dependencies) on packageName."
	
	^ [ DAMessageSendAnalyzer on: packageName ]
		on: PotentialOutDatedDependencyWarning
		do: [:ex | ex resume ]