tests
testShouldGetStaticAndManuallyResolvedDependencies
	| deps |
	
	deps := CGOPackageDependencyUpdater new
		dependenciesOf: ManifestFoo.
	self 
		assertCollection: #(#'System-Settings' #'System-Localization' #Compression #'AST-Core' #Kernel #'Multilingual-TextConversion' #'System-Platforms'  #'System-Sources' #Transcript #'Random-Core') 
		hasSameElements: deps