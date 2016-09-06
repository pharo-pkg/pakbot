initialization
initializeCargoRepositoryVirtualIndex
	self cargoPackageVersions
		do: [ :pkgVersion | cargoRepository updateVirtualPackagesIndexWith: pkgVersion ]