configuring
installedPackages: aListOfPackageVersions
	resolution alreadyInstalledPackages: aListOfPackageVersions.
	"For each package already installed in the image, add a constraint on the installed version before running the solving"
	aListOfPackageVersions
		do: [ :pkgVersion |
			self 
				addConstraint: (CGOFixedVersionConstraint with: pkgVersion version)
				on: pkgVersion packageName ]