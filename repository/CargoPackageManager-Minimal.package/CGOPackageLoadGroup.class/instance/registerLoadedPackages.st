loading
registerLoadedPackages
	self packageVersions
		do: [ :pkgVersion | 
			pkgVersion versionLoaded.
			CGOPackageRegistry default register: pkgVersion ]