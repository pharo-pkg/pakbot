tests
testCanCreateMonticelloHostedPackageVersion
	ongoingPkg updateSourcePackage: 
	'{ #backend -> #monticello .
		#repositoryUrl -> ''http://smalltalkhub.com/mc/Foo/Bar/main/'' .
		#packageName -> #''Foo-Core'' .
		#versionString -> ''JohnDoe.0'' } asDictionary'.
	
	self 
		assert: ongoingPkg sourceRepository class 
		equals: CGOMonticelloHostedPackageVersion 