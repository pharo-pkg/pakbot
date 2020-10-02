"
Common class representing a dependency to a package.
"
Class {
	#name : #PBAbstractPackageDependency,
	#superclass : #PBAbstractDependency,
	#instVars : [
		'targetedPackage'
	],
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #accessing }
PBAbstractPackageDependency >> packageName [
	self subclassResponsibility
]

{ #category : #accessing }
PBAbstractPackageDependency >> targetedPackage [
	^ targetedPackage
]
