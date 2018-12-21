"
I represent a Cargo project ready to be serialized.
I map some instance variables to an easily serialized form.
"
Class {
	#name : #PBSerializedProject,
	#superclass : #PBSerializedArtefact,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #initialization }
PBSerializedProject >> initializeWithPackage: aPBProject [
	super initializeWithPackage: aPBProject.
	dict at: #version put: aPBProject version asString.
	self
		addPropertyNamed: #dependencies 
		ifNotEmptyOrNil: ((aPBProject resolve resolvedDependencies) 
								sorted: [ :first :second | first name < second name ]).
	"used for package dependencies
	self
		addPropertyNamed: #externalProjects 
		ifNotEmptyOrNil: (aPBProject externalProjects)."
	self 
		addPropertyNamed: #units
		ifNotEmptyOrNil: (self sort: aPBProject packageUnits andCollect: #asSerializedPackage).
	self
		addPropertyNamed: #assemblies 
		ifNotEmptyOrNil: (self sort: aPBProject assemblies andCollect: #asSerializedPackage).
	self 
		addPropertyNamed: #virtualPackages 
		ifNotEmptyOrNil: (self sort: aPBProject virtualPackages andCollect: #asSerializedPackage).
]
