building groups
buildGroupItemsOn: items
	| group |
	project project assemblies
		do: [ :each | 
			group := CGOClyPackageAssembly of: project on: each.
			items add: group asEnvironmentItem ].
	project project virtualPackages
		do: [ :each | 
			group := CGOClyVirtualPackage of: project on: each.
			items add: group asEnvironmentItem ]