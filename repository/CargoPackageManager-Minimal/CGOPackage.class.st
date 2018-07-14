"
A Package represents the unit of distribution of source/binary code.
It has a name to identify it.
All other attributes may evolve with the time, and so, are handled by a PackageVersion.
"
Class {
	#name : #CGOPackage,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
CGOPackage class >> newNamed: aName [
	^ self new
		initializeWithName: aName asSymbol;
		yourself
]

{ #category : #'as yet unclassified' }
CGOPackage class >> stonName [

	^ #'Package'
]

{ #category : #protocol }
CGOPackage >> dependentPackages [
	^ CGOPackageRegistry default installedPackages
		collect: [ :aPackage | aPackage dependencies
								select: [ : aDependency | aDependency targetedPackage = self ] ]
]

{ #category : #initialization }
CGOPackage >> initializeWithName: aName [
	super initialize.
	name := aName
]

{ #category : #testing }
CGOPackage >> isPlatformPackage [
	^ false
]

{ #category : #testing }
CGOPackage >> isVirtual [
	^ false
]

{ #category : #accessing }
CGOPackage >> name [
	^ name
]

{ #category : #printing }
CGOPackage >> printOn: aStream [
	aStream << name
]

{ #category : #ston }
CGOPackage >> stonOn: stonWriter [
	stonWriter writeString: name
]
