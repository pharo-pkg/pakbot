Class {
	#name : #PBConfigurationConflictTest,
	#superclass : #PBParametrizedConflictTest,
	#category : #'CargoPackageManager-IntegrationTests-Conflicts'
}

{ #category : #'building suites' }
PBConfigurationConflictTest class >> testParameters [

	^ ParametrizedTestMatrix new

		"Configurations"
		"Nothing Installed"
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createConfiguration: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createConfiguration: '1.0' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createConfiguration: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createConfiguration: '2.0' ]. #expectedConflicts -> false};

		"Installed And 2 Dependencies"
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '1.0' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test createInstalledConfiguration: '2.0' ]. #expectedConflicts -> false};

		"Installed And 1 Dependencies"
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '1.0' ]. #dependencyTwo -> [ :test | test installConfiguration: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: '2.0' ]. #dependencyTwo -> [ :test | test installConfiguration: '2.0' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test installConfiguration: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createConfiguration: #stable ]. #dependencyTwo -> [ :test | test installConfiguration: '2.0' ]. #expectedConflicts -> false};

		yourself
]
