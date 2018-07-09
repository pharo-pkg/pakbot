initialization
initializeWidgets
	overview := CGOPackageOverview newOn: ongoingPackageUnit owner: self.
	dependencies := CGOPackageDependenciesView newOn: ongoingPackageUnit owner: self.