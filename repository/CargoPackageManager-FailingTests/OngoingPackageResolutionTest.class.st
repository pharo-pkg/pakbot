Class {
	#name : #OngoingPackageResolutionTest,
	#superclass : #CGOTest,
	#category : 'CargoPackageManager-FailingTests-Solver'
}

{ #category : #accessing }
OngoingPackageResolutionTest class >> resources [
	^ #()
]

{ #category : #tests }
OngoingPackageResolutionTest >> testEquals [
	| resolvedDep1 resolvedDep2 pkgA pkgB dep1 dep2 |
	
	pkgA := #A.
	pkgB := #B.
	resolvedDep1 := PBResolvedProject new
				targetedPackage: pkgA;
				yourself.
	resolvedDep2 := PBResolvedProject new
				targetedPackage: pkgB;
				yourself.
	self assert: (resolvedDep1 = resolvedDep2) not.
	resolvedDep2 targetedPackage: pkgA.
	self assert: resolvedDep1 equals: resolvedDep2.
	
	resolvedDep1 := PBResolvedProject new
				resolvedProjectVersion: (CGOPackageVersion fromString: 'pkgA@1');
				yourself.
	resolvedDep2 := PBResolvedProject new
				resolvedProjectVersion: (CGOPackageVersion fromString: 'pkgA@1.1');
				yourself.
	self assert: (resolvedDep1 = resolvedDep2) not.
	resolvedDep2 resolvedProjectVersion: (CGOPackageVersion fromString: 'pkgA@1').
	self assert: resolvedDep1 equals: resolvedDep2.

	dep1 :=  CGOPackageDependency on: pkgA for: nil.
	dep2 :=  CGOPackageDependency on: pkgB for: nil.
	resolvedDep1 := PBResolvedProject new
				instVarNamed: 'originDependencies' put: dep1;
				yourself.
	resolvedDep2 := PBResolvedProject new
				instVarNamed: 'originDependencies' put: dep2;
				yourself.
	self assert: (resolvedDep1 = resolvedDep2) not.
	resolvedDep2 instVarNamed: 'originDependencies' put: (CGOPackageDependency on: pkgA for: nil).
	self assert: resolvedDep1 equals: resolvedDep2.
]
