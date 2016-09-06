computing
staticDependenciesOf: manifest
	^ (self staticAnalysisFor: manifest packageName) packageStaticDependencies