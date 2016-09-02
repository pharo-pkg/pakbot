loading
mcVersions
	^ packageVersions
		reject: #isAssembly "Assemblies are not associated to a code artefact, so nothing to load ..."
		thenCollect: [ :pkgVersionRef | self mcVersionFor: pkgVersionRef ]