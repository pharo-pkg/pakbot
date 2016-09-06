initialization
initializeCargoRepository
	| cargoDirectory |
	cargoDirectory := fs / 'cargo-repo'.
	self cargoPackageVersions , self cargoFakePackageVersions
		do:
			[ :pkgVersion | 
			(cargoDirectory / pkgVersion packageName) ensureCreateDirectory.
			cargoDirectory / pkgVersion packageName / pkgVersion name
				writeStreamDo: [ :stream | stream nextPutAll: (CGOPackageVersionWriter toStringPretty: pkgVersion) ] ].
	cargoRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: cargoDirectory;
		initialize;
		yourself.
	self initializeCargoRepositoryVirtualIndex