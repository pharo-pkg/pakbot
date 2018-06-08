tests - test data
pharoCounterMaster
	^ CGOGitRepositoryCreator new
		githubUrl: 'github://demarey/pharo-counter:master';
		location: self gitRepoUniqueLocation;
		create
		