Class {
	#name : #PBProjectScope,
	#superclass : #ClyTypedScope,
	#category : #'CargoPackageManager-Calypso-Environment'
}

{ #category : #accessing }
PBProjectScope >> project [
	^ self basisObjects anyOne
]
