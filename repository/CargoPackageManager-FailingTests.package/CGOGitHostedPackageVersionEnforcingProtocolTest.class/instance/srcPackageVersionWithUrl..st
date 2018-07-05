input
srcPackageVersionWithUrl: url
	^ CGOGitHostedPackageVersionEnforcingProtocol
		repositoryUrl: url
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: 'b9ee048f40e500198120aedf8db60266caa9ece9'