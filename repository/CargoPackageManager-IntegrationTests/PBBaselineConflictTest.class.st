Class {
	#name : #PBBaselineConflictTest,
	#superclass : #PBParametrizedConflictTest,
	#category : #'CargoPackageManager-IntegrationTests-Conflicts'
}

{ #category : #'building suites' }
PBBaselineConflictTest class >> testParameters [

	^ ParametrizedTestMatrix new

		"Baseline"
		"Nothing Installed"
		addCase: { #dependencyOne -> [ :test | test createBaseline: '1.0' ]. #dependencyTwo -> [ :test | test createBaseline: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createBaseline: '0866472ddded2a8fc36d3bae23f01aecfe947dc7' ]. #dependencyTwo -> [ :test | test createBaseline: '0866472ddded2a8fc36d3bae23f01aecfe947dc7' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createBaseline: 'master' ]. #dependencyTwo -> [ :test | test createBaseline: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createBaseline: 'master' ]. #dependencyTwo -> [ :test | test createBaseline: '2.0' ]. #expectedConflicts -> true};

		"Installed And 1 Dependencies"
		addCase: { #dependencyOne -> [ :test | test createBaseline: '1.0' ]. #dependencyTwo -> [ :test | test installBaseline: '2.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createBaseline: '0866472ddded2a8fc36d3bae23f01aecfe947dc7' ]. #dependencyTwo -> [ :test | test installBaseline: '0866472ddded2a8fc36d3bae23f01aecfe947dc7' ]. #expectedConflicts -> false};
		addCase: { #dependencyOne -> [ :test | test createBaseline: 'master' ]. #dependencyTwo -> [ :test | test installBaseline: '1.0' ]. #expectedConflicts -> true};
		addCase: { #dependencyOne -> [ :test | test createBaseline: 'master' ]. #dependencyTwo -> [ :test | test installBaseline: '2.0' ]. #expectedConflicts -> true};

		yourself
]
