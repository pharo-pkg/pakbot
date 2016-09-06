*CargoPackageManager-RepositoryBackend
mongoVersion
	<mongoDescription>
	^ VOMongoToOneDescription new
		attributeName: 'version';
		accessor: (MAPluggableAccessor
			read: [ :pkgVersion | pkgVersion version asString ]
			write: [ :pkgVersion :value | 
					pkgVersion 
						instVarNamed: 'version'
						put:  (SemanticVersion fromString: value)] );
		yourself