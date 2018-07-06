building groups
buildGroupItemsOn: items
	| group |
	project project assemblies
		do: [ :each | 
			group := CGOClyPackageAssembly of: project on: each.
			items add: group asCalypsoBrowserItem ].
	project project virtualPackages
		do: [ :each | 
			group := CGOClyVirtualPackage of: project on: each.
			items add: group asCalypsoBrowserItem ]