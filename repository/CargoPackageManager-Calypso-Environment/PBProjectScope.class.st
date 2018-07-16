Class {
	#name : #PBProjectScope,
	#superclass : #ClyTypedScope,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #accessing }
PBProjectScope >> project [
	^ self basisObjects anyOne
]
