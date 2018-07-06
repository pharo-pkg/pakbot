loading
loadCargoProjects
	self packageVersions
		reject: #isAssembly "Assemblies are not associated to a code artefact, so nothing to load ..."
		thenDo: [ :pkgVersion | pkgVersion repository loadPackageNamed: pkgVersion packageName ]