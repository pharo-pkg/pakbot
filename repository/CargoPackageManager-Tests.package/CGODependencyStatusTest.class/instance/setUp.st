running
setUp
	super setUp.
	registry := CGOPackageRegistry new.
	project := CGOOngoingProject named: 'ATestProject'.
	registry register: project.

	dependencyToProject := self createProjectDependency.

	project newPackageUnit: #APackage.
	project addDependency: dependencyToProject