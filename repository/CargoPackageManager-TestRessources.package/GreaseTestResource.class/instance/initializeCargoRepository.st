initialization
initializeCargoRepository
	| cargoDirectory |
	cargoDirectory := fs / 'cargo-repo'.
	self cargoPackageVersions , self cargoFakePackageVersions
		do:
			[ :pkgVersion | 
			(cargoDirectory / pkgVersion packageName asLowercase) ensureCreateDirectory.
			cargoDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase
				writeStreamDo: [ :stream | stream nextPutAll: (CGOPackageVersionWriter toStringPretty: pkgVersion) ] ].
	cargoRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: cargoDirectory;
		initialize;
		yourself.
	self initializeCargoRepositoryVirtualIndex