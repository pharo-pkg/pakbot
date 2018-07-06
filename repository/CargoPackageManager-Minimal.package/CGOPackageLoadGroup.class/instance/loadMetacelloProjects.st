loading
loadMetacelloProjects
	self packageVersions 
		select: #isMetacelloProject 
		thenDo: [ :each | each load ]