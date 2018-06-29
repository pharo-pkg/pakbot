accessing
metacelloProjects
	^ externalProjects 
		select: #isMetacelloProjectDependency
		thenCollect: [ :each| CGOMetacelloProject fromProjectDependency: each ]