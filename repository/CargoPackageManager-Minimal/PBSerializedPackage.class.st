"
I represent a Package unit ready to be serialized.
I map some instance variables of PackageVersion to an easily serialized form (e.g. String, Array)
"
Class {
	#name : #PBSerializedPackage,
	#superclass : #PBVcsSerializedPackageUnit,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #initialization }
PBSerializedPackage >> initializeWithPackage: aPBPackage [
	super initializeWithPackage: aPBPackage.
	"self 
		addPropertyNamed: #dependencies 
		ifNotEmptyOrNil: (self serializedDependenciesOf: aCGOOngoingPackageUnit dependencies)."

]
