Class {
	#name : #PBProjectItemScope,
	#superclass : #ClyTypedScope,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #accessing }
PBProjectItemScope >> item [
	^ self basisObjects anyOne
]
