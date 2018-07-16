Class {
	#name : #PBProjectPackageScope,
	#superclass : #ClyTypedScope,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #iterating }
PBProjectPackageScope >> classesDo: aBlockClosure [

	^ self basisObjects select: [ :each | each isInstalled ] thenDo: [ :each | each systemPackage classes do: aBlockClosure ]
]

{ #category : #accessing }
PBProjectPackageScope >> packagesDo: aBlockClosure [ 
	^ self basisObjects select: [ :each | each isInstalled ] thenDo: [ :each | aBlockClosure value: each systemPackage  ]
]
