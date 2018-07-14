"
TestRessources to get all packages description of Seaside 3.1
"
Class {
	#name : #Seaside31TestResource,
	#superclass : #TestResource,
	#instVars : [
		'packageProviderStrategyBackup',
		'packageVersions'
	],
	#category : 'CargoPackageManager-TestRessources-Resources'
}

{ #category : #accessing }
Seaside31TestResource >> seaside31PackageVersions [
	^ packageVersions
]

{ #category : #accessing }
Seaside31TestResource >> seaside31Packages [
	^ packageVersions collect: #package
]

{ #category : #running }
Seaside31TestResource >> setUp [
	super setUp.
	packageProviderStrategyBackup := CGOPackageProvider default providerStrategy.
	CGOPackageProvider default providerStrategy: CGOInImagePackageProviderStrategy new.
	packageVersions := (Seaside31PackageSpec allSubclasses 
					reject: [ :packageSpec | packageSpec = SeasidePharo30CanvasSpec ]
					thenCollect: [ :packageSpec | packageSpec new buildPackage ] ) asArray.

]

{ #category : #running }
Seaside31TestResource >> tearDown [
	super tearDown.
	CGOPackageProvider default providerStrategy: packageProviderStrategyBackup
]
