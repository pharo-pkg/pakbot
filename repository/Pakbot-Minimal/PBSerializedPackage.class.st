"
I represent a Package unit ready to be serialized.
I map some instance variables of PackageVersion to an easily serialized form (e.g. String, Array)
"
Class {
	#name : #PBSerializedPackage,
	#superclass : #PBVcsSerializedPackageUnit,
	#category : #'Pakbot-Minimal-Serialization'
}

{ #category : #initialization }
PBSerializedPackage >> initializeWithPackage: aPBPackage [
	super initializeWithPackage: aPBPackage.
	"self 
		addPropertyNamed: #dependencies 
		ifNotEmptyOrNil: (self serializedDependenciesOf: aCGOOngoingPackageUnit dependencies)."

]
