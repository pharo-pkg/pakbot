example
example
	^ (self for: #'Test')
		version: '0.1-dev';
		description: 'A simple ongoing package unit.';
		sourcePackageVersion: 
			(CGOGitHostedPackageVersion
				repositoryUrl: 'git@github.com:foo/bar.git'
				subdirectory: 'repository'
				packageName: 'Test-Core'
				commitish: 'master')