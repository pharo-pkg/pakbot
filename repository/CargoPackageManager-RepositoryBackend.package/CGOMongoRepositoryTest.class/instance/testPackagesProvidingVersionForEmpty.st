tests - virtual packages
testPackagesProvidingVersionForEmpty
	| result |
	
	result := repository 
				packagesProviding: #'Seaside-Canvas-Platform'
				version: '3.1' asSemanticVersion
				for: (OrderedCollection with: #'pharo4.x').
	self 
		assert: result size
		equals: 0