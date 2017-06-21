initialization
repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitOrTag
	repository:= CGOGitRepository 
		repositoryUrl: (useHttpsUrl 
			ifTrue: [ self httpUrlFrom: gitUrlString ]
			ifFalse: [ self sshUrlFrom: gitUrlString ])
		subdirectory: directoryName.
	packageName := pkgName asSymbol.
	commitish := commitOrTag 