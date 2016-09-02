checking
checkRepositories
	self repositories 
		ifEmpty: [ CGOMissingSourcePackageRepository 
							signal: 'No source repository defined for: ' , self packageName ]