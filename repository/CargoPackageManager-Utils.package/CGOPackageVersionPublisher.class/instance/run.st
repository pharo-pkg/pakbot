running
run
	manifests do: [ :manifest |
		self publishPackageVersion: manifest asOngoingPackageVersion ]