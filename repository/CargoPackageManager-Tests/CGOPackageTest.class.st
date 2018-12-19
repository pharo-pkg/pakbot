"
A PackageTest is a test class for testing the behavior of Package
"
Class {
	#name : #CGOPackageTest,
	#superclass : #CGOTest,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #accessing }
CGOPackageTest class >> resources [
	^ #()
]

{ #category : #tests }
CGOPackageTest >> testIsPlatformPackage [
	| package |
	
	package := CGOPackageProvider default packageNamed: 'Test'.
	self deny: package isPlatformPackage.
		 
	package := CGOPackageProvider default virtualPackageNamed: 'Test-Platform'.
	self assert: package isPlatformPackage
]
