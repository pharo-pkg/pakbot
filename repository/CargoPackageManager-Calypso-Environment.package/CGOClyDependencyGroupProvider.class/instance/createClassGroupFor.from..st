building groups
createClassGroupFor: aClassQuery from: aPackageScope
	| subquery |
	subquery := CGOClyPackageDependencies sortedFrom: aPackageScope.
	
	^CGOClyPackageDependencyGroup 
		named: 'Dependencies' 
		priority: -1000
		on: aClassQuery		
		withSubgroupsFrom: subquery