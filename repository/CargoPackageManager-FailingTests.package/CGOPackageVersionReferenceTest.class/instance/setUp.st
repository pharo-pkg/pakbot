running
setUp 
	| remoteRepositoryMock |
	pkgVersionReference := CGOPackageVersionReference newOn: 'Seaside-Core@3.1.0'.
	remoteRepositoryMock := protocol mock: 'remoteRepositoryMock'.
	protocol describe
		allow: remoteRepositoryMock recv: #fetch:version:;
		=> self resolvedProjectVersion.
	pkgVersionReference packageRepositories: { remoteRepositoryMock }