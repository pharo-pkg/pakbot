as yet unclassified
seaside31PPMResolution
	| aPackageVersion dependencyToSolve |
	
	aPackageVersion := Seaside31Spec new buildPackage.
	dependencyToSolve := CGOPackageDependency 
								on: aPackageVersion package
								for: nil
								withConstraints: (CGOFixedVersionConstraint with: '3.1').
	CGOSolver new	solveDependency: dependencyToSolve.
