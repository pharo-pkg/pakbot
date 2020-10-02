"
Test ressource to get an installation request solving.
This example is based on Fame.
"
Class {
	#name : #FooDependencyResolutionResource,
	#superclass : #TestResource,
	#instVars : [
		'packages',
		'packageProviderStrategyBackup',
		'resolution'
	],
	#category : #'CargoPackageManager-TestRessources-Resources'
}

{ #category : #packages }
FooDependencyResolutionResource >> aPackage [
	^ CGOPackageUnit newFrom: { 
		#package -> #A .
		#version -> '1.0' .
		#dependencies -> { #B -> #('=3.1') . #C -> #('=1.0') }
	} asDictionary
]

{ #category : #building }
FooDependencyResolutionResource >> addResolvedPackage: aSelector [
	| packageVersion |
	packageVersion := self perform: aSelector.
	(resolution ongoingPackageResolutionFor: packageVersion packageName)
		resolvedProjectVersion: packageVersion
]

{ #category : #packages }
FooDependencyResolutionResource >> bPackage [
	^ CGOPackageUnit newFrom: { 
		#package -> #B .
		#version -> '3.1' .
		#dependencies -> { #D -> #('=1.1') }
	} asDictionary
]

{ #category : #packages }
FooDependencyResolutionResource >> cPackage [
	^ CGOPackageUnit newFrom: { 
		#package -> #C .
		#version -> '1.0' 
	} asDictionary
]

{ #category : #packages }
FooDependencyResolutionResource >> dPackage [
	^ CGOPackageUnit newFrom: { 
		#package -> #D .
		#version -> '1.1' .
		#dependencies -> { #B -> #('=3.1') }
	} asDictionary
]

{ #category : #building }
FooDependencyResolutionResource >> dependencyResolution [
	resolution := CGODependencyResolution new.
	resolution rootProject: self rootDependency.
	(self class methodsInProtocol: #packages) 
		do: [ :each | self addResolvedPackage: each selector ].
	^ resolution
]

{ #category : #packages }
FooDependencyResolutionResource >> ePackage [
	^ CGOPackageUnit newFrom: { 
		#package -> #E .
		#version -> '1.0'
	} asDictionary
]

{ #category : #packages }
FooDependencyResolutionResource >> fooPackage [
	^ CGOPackageUnit newFrom: { 
		#package -> #Foo .
		#version -> '1.0' .
		#parts -> { #A -> #('=1.0') . #E -> #('=1.0') }
	} asDictionary
]

{ #category : #building }
FooDependencyResolutionResource >> rootDependency [
	^ PBPackageDependency 
		on: self fooPackage packageName
		for: nil
		withConstraints: { CGOFixedVersionConstraint with: '1.0' }
]
