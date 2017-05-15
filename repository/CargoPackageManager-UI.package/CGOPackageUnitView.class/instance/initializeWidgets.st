initialization
initializeWidgets
	packageOverview := CGOPackageOverview newOn: ongoingPackageUnit owner: self.
	dependenciesView := CGOPackageDependenciesView newOn: ongoingPackageUnit owner: self.