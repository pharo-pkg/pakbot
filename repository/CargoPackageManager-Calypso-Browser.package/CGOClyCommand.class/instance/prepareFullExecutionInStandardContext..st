execution
prepareFullExecutionInStandardContext: aToolContext
	| packageManagers |
	super prepareFullExecutionInStandardContext: aToolContext.
	toolContext := aToolContext.
	
	packageManagers := aToolContext systemEnvironment projectManager packageManagers.
	packageManagers size = 1
		ifTrue: [ packageManager := packageManagers first ]
		ifFalse: [ self shouldBeImplemented ].