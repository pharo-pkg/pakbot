tests
testResolutionOfUnexistentPackageVersionShouldFail

	| solver |
	solver := CGOSolver new.
	self should: [ solver solvePackageNamed: #'Unexistent' version: '1.0' ] raise: CGOUnresolvedDependency