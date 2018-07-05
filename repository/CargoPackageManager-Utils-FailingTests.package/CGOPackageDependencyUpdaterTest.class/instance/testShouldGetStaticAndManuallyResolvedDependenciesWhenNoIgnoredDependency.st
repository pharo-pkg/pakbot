tests
testShouldGetStaticAndManuallyResolvedDependenciesWhenNoIgnoredDependency
	| deps |
	
	deps := CGOPackageDependencyUpdater new
		dependenciesOf: ManifestFooWithNoIgnored.
	self 
		assertCollection: #(#'System-Localization' #Compression #'AST-Core' #Kernel #'Multilingual-TextConversion' #'System-Platforms' #'FFI-Kernel' #'System-Sources' #Transcript #'Random-Core' #'Regex-Core') 
		hasSameElements: deps