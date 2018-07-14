"
Common class representing a dependency to a package.
"
Class {
	#name : #CGOAbstractPackageDependency,
	#superclass : #CGOAbstractDependency,
	#instVars : [
		'targetedPackage'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #accessing }
CGOAbstractPackageDependency >> packageName [
	self subclassResponsibility
]

{ #category : #accessing }
CGOAbstractPackageDependency >> targetedPackage [
	^ targetedPackage
]
