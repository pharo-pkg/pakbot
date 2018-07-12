tests
expectedCargoResolvedProject

	^ (CGOOngoingProject named: 'test-project-source-properties-tonel')
		repository: (CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:pharo-vcs/test-project-source-properties-tonel.git');
		version: (SemanticVersion fromString: '0-N/A')