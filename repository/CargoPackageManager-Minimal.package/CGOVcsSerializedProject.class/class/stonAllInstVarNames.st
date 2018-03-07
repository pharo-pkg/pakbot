ston-core
stonAllInstVarNames
	"Override to encode my instances using a custom set of instance variables or to define their order."
	| instVarNames |
	instVarNames := #(#name #description #externalProjects #units #assemblies #virtualPackages).
	self 
		assert: instVarNames size = self allInstVarNames size
		description: 'Error: some instance variable will not be serialized!'.
	^ instVarNames