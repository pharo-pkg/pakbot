test data
project
	^ ongoingProject asCargoProject 
		instVarNamed: 'version' put: '1' asSemanticVersion;
		yourself