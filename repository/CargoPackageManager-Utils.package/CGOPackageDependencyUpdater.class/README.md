Will update, if needed, the #dependencies method of package manifest with :
	* static dependencies as computed by the Dependency Analyzer
	* manually resolved dependencies (warning if not up-to-date)
	* and take care to remove ignored dependencies

example: 
	self updateDependenciesOf: { ManifestFoo }.

	self updateTransitiveDependenciesOf:  (AssemblyManifest packageNamed: 'Pharo-Kernel')