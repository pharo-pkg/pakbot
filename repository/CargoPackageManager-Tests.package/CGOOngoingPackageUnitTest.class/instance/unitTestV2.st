test data
unitTestV2
	^ (CGOOngoingPackageUnit for: #'Test')
		version: '0.2-dev';
		description: 'A simple ongoing package unit.';
		sourcePackageVersion: (CGOGitHostedPackageVersion
			repositoryUrl: 'git@github.com:foo/bar.git'
			subdirectory: 'repository'
			packageName: 'Test-Core2'
			commitish: 'master').