Class {
	#name : #CGOTest,
	#superclass : #TestCase,
	#instVars : [
		'systemPackages',
		'packageProviderStrategyBackup'
	],
	#category : #'CargoPackageManager-TestRessources-Resources'
}

{ #category : #testing }
CGOTest class >> isAbstract [
	^ self name = #CGOTest
]

{ #category : #accessing }
CGOTest class >> resources [
	^ { Seaside31TestResource }
]

{ #category : #accessing }
CGOTest >> packageVersions [
	^ Seaside31TestResource current seaside31PackageVersions
]

{ #category : #accessing }
CGOTest >> packages [
	^ Seaside31TestResource current seaside31Packages
]

{ #category : #accessing }
CGOTest >> virtualPackageNames [
	^ Seaside31TestResource current seaside31PackageVersions
		flatCollect: 
			[ :each | 
			each provisions collect: 
				[ :provision | provision asPackageVersionReference packageName ] ]
		as: Set 
]

{ #category : #accessing }
CGOTest >> virtualPackageVersions [
	^ self virtualPackageNames
		collect: [:name | CGOVirtualPackageVersion fromString: name,'@1.0']
		
]

{ #category : #accessing }
CGOTest >> virtualPackages [
	^ self virtualPackageNames
		collect: [:pkgName | CGOPackageProvider default virtualPackageNamed: pkgName ]
]
