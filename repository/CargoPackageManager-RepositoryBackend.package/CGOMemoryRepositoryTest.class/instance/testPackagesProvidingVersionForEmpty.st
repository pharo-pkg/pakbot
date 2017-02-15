tests - virtual packages
testPackagesProvidingVersionForEmpty
	| result |
	
	result := repository 
				packagesProviding: 'Seaside-Canvas-Platform'
				version: '1.0' asSemanticVersion
				forPlatformAttributes: (OrderedCollection with: #'pharo4.x').
	self 
		assert: result size
		equals: 0