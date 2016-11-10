checking
checkRepositories
	self repositories 
		ifEmpty: [ CGOMissingSourcePackageDefinition 
							signal: 'No source repository defined for: ' , self packageName ]