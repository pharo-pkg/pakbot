instance creation
fromStringUrl: url subdirectory: subdirectoryName
	^ (self isGitRepositoryUrl: url)
		ifTrue: [ CGOGitRepository 
			repositoryUrl: url
			subdirectory: subdirectoryName ]
		ifFalse: [ CGOMonticelloRepository repositoryUrl: url ]