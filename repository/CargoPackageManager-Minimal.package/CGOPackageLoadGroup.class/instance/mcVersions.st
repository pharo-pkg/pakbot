loading
mcVersions
	^ self packageVersions
		reject: #isAssembly "Assemblies are not associated to a code artefact, so nothing to load ..."
		thenCollect: [ :pkgVersion | self mcVersionFor: pkgVersion ]