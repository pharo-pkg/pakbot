test data
greaseRepository
	^ (CGOGitRepositoryCreator repositoryCreatorWithUrl: 'https://github.com/demarey/Grease-cargo.git')
		subdirectory: 'repository';
		create