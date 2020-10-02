Class {
	#name : #Seaside31BasedTest,
	#superclass : #RepositoryBasedTest,
	#instVars : [
		'seaside31Dependency',
		'seaside31PackageVersion'
	],
	#category : #'CargoPackageManager-FailingTests-Functional'
}

{ #category : #running }
Seaside31BasedTest >> setUp [
	super setUp.
	seaside31PackageVersion := self packageVersions
		detect: [ :each | each packageName = 'Seaside31' ].
	seaside31Dependency := PBPackageDependency
									on: seaside31PackageVersion package name
									for: nil
									withConstraints: { CGOFixedVersionConstraint with: '3.1' }
]
