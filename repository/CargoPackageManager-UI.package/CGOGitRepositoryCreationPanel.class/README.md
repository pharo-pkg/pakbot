I'm in charge of creating a new Git repository and execute some actions onthe newly created repository.

I reuse Iceberg  UI to create new repositories and regiter to Iceberg announcer to act on the first  IceRepositoryCreated announcement.

You can try me with :
	self  withNewRepositoryDo: [: repo | repo inspect ]