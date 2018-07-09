building
buildRepository
	^ CGOGitRepositoryCreator new
		url: 'https://github.com/pharo-project/pharo-launcher.git';
		version: 'development';
		subdirectory: 'src';
		create