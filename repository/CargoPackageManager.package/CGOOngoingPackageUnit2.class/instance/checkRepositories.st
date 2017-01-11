checking
checkRepositories
	src 
		ifNil: [ CGOMissingSourcePackageDefinition 
							signal: 'No source repository defined for: ' , self packageName ]