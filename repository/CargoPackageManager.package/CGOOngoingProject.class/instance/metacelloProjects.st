accessing
metacelloProjects
	^ externalProjects 
		select: #isMetacelloProjectDependency
		thenCollect: [ :projectDependency | CGOMetacelloProject fromProjectDependency: projectDependency ]