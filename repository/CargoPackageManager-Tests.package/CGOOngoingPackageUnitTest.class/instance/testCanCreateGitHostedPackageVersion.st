tests
testCanCreateGitHostedPackageVersion
	ongoingPkg updateSourcePackage: 
	'{ #backend -> #git .
		#repositoryUrl -> ''http://smalltalkhub.com/mc/Foo/Bar/main/'' .
		#packageName -> #''Foo-Core'' .
		#subdirectory -> nil .
		#commitish -> #e2abdh } asDictionary'.
	
	self 
		assert: ongoingPkg sourceRepository class 
		equals: CGOGitHostedPackageVersion 