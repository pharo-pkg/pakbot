building items
buildAssemblyItemsOn: items
	| group |
	cargoAssembly assemblies
		do: [ :each | 
			group := CGOClyPackageAssembly of: project on: each.
			items add: group asEnvironmentItem ]