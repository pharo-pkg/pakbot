"
Strategy used to provides instances of Packages from the image.
This strategy holds a dictionary with previously created packages.
"
Class {
	#name : #CGOInImagePackageProviderStrategy,
	#superclass : #Object,
	#instVars : [
		'packages'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'private - instance creation' }
CGOInImagePackageProviderStrategy >> createPackage: aName [
	^ self createPackage: aName class: CGOPackage
]

{ #category : #'private - instance creation' }
CGOInImagePackageProviderStrategy >> createPackage: aName class: packageClass [
	^ packages 
		at: aName asSymbol
		put: (packageClass newNamed: aName)
]

{ #category : #'private - instance creation' }
CGOInImagePackageProviderStrategy >> createVirtualPackage: aName [
	^ self createPackage: aName class: CGOVirtualPackage
]

{ #category : #initialization }
CGOInImagePackageProviderStrategy >> initialize [
	super initialize.
	packages := Dictionary new
]

{ #category : #providing }
CGOInImagePackageProviderStrategy >> packageNamed: aName [
	^ packages
		at: aName asSymbol
		ifAbsent: [ self createPackage: aName ]
]

{ #category : #providing }
CGOInImagePackageProviderStrategy >> virtualPackageNamed: aName [
	^ packages
		at: aName asSymbol
		ifPresent: [ :package |
						package isVirtual
							ifTrue: [ package ]
							ifFalse: [ self error: aName , ' is not a virtual package!'] ]
		ifAbsent: [ self createVirtualPackage: aName ]
]
