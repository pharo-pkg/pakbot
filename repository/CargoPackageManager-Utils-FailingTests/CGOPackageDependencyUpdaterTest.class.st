Class {
	#name : #CGOPackageDependencyUpdaterTest,
	#superclass : #Object,
	#instVars : [
		'manifests'
	],
	#category : 'CargoPackageManager-Utils-FailingTests'
}

{ #category : #tests }
CGOPackageDependencyUpdaterTest >> testShouldGetAllCurrentDependenciesOfPackageUnit [
	| deps |
	
	deps := CGOPackageDependencyUpdater allCurrentDependenciesOfManifest: ManifestOneDependency.
	
	self 
		assertCollection: deps
		hasSameElements: #(#OneDependency #NoDependency)
]

{ #category : #tests }
CGOPackageDependencyUpdaterTest >> testShouldGetStaticAndManuallyResolvedDependencies [
	| deps |
	
	deps := CGOPackageDependencyUpdater new
		dependenciesOf: ManifestFoo.
	self 
		assertCollection: #(#'System-Settings' #'System-Localization' #Compression #'AST-Core' #Kernel #'Multilingual-TextConversion' #'System-Platforms'  #'System-Sources' #Transcript #'Random-Core') 
		hasSameElements: deps
]

{ #category : #tests }
CGOPackageDependencyUpdaterTest >> testShouldGetStaticAndManuallyResolvedDependenciesWhenNoIgnoredDependency [
	| deps |
	
	deps := CGOPackageDependencyUpdater new
		dependenciesOf: ManifestFooWithNoIgnored.
	self 
		assertCollection: #(#'System-Localization' #Compression #'AST-Core' #Kernel #'Multilingual-TextConversion' #'System-Platforms' #'FFI-Kernel' #'System-Sources' #Transcript #'Random-Core' #'Regex-Core') 
		hasSameElements: deps
]
