accessing
metacelloProjects
	^ externalProjects 
		select: #isMetacelloProjectDependency
		thenCollect: [ :projectDependency | PBMetacelloProject fromProjectDependency: projectDependency ]