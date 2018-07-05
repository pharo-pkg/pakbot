asserting
assertSrcPackageVersion: srcPackageVersion repositoryUrlEquals: aUrl
	^ self
		assert:
			((srcPackageVersion instVarNamed: 'repository')
				instVarNamed: 'repositoryUrl')
		equals: aUrl