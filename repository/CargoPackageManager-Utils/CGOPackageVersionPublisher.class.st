"
Utility class to automatize the publication of package versions.
"
Class {
	#name : #CGOPackageVersionPublisher,
	#superclass : #Object,
	#instVars : [
		'pkgRepository',
		'srcRepositories',
		'versionBlock',
		'manifests',
		'shouldPublishDependencies',
		'visited'
	],
	#category : 'CargoPackageManager-Utils'
}

{ #category : #utility }
CGOPackageVersionPublisher class >> fixPackageUnitNamesOf: aListOfPackageManifest [
	"Iterate on Package manifests to create or fix the package name when possible.
	example: 
		self fixPackageUnitNamesOf: ((AssemblyManifest packageNamed: 'Pharo-Kernel') asOngoingPackageVersion packageUnits collect: #packageManifest)
	"
		
	aListOfPackageManifest do: [ :manifest | | packageName |
		packageName := manifest package packageName.
		((manifest class includesSelector: #packageName) and: [ manifest packageName = packageName ])
			ifFalse: 
				[ self inform: 'Updating ' , packageName, ' manifest'.
				manifest asOngoingPackageVersion updatePackageName: packageName ] ]
]

{ #category : #'instance creation' }
CGOPackageVersionPublisher class >> on: aCGODirectoryPackageRepository [ 
	^ self new
		initializeWith: aCGODirectoryPackageRepository;
		yourself
]

{ #category : #initialization }
CGOPackageVersionPublisher >> initializeWith: aCGODirectoryPackageRepository [ 
	pkgRepository := aCGODirectoryPackageRepository.
	manifests := Set new.
	shouldPublishDependencies := false.
	visited := Set new
]

{ #category : #private }
CGOPackageVersionPublisher >> manifestFor: aPackageName [ 
	^ [ PackageManifest packageNamed: aPackageName ]
		on: NotFound 
		do: [ [ AssemblyManifest packageNamed: aPackageName ]
				on: NotFound 
				do: [ NotFound signalFor: aPackageName ] ]
]

{ #category : #configuring }
CGOPackageVersionPublisher >> manifests: aListOfManifest [ 
	manifests addAll: aListOfManifest
]

{ #category : #private }
CGOPackageVersionPublisher >> manifestsFor: aListOfPackageNames [ 
	^ aListOfPackageNames 
		collect: [ :pkgName | self manifestFor: pkgName ]

]

{ #category : #configuring }
CGOPackageVersionPublisher >> packages: packageNames [ 
	self manifests: (self manifestsFor: packageNames)

]

{ #category : #configuring }
CGOPackageVersionPublisher >> publishDependencies [
	shouldPublishDependencies := true
]

{ #category : #running }
CGOPackageVersionPublisher >> publishPackageVersion: ongoing [
	(visited includes: ongoing)
		ifTrue: [ ^ self ]
		ifFalse: [ visited add: ongoing ].

	shouldPublishDependencies 
		ifTrue: [ self publishPackages: (ongoing dependencies collect: #targetedPackage) ].
	ongoing isUnit ifTrue: [ 
		srcRepositories ifNotNil: 
			[ ongoing updateRepositories: srcRepositories ] ].
	versionBlock ifNotNil: 
		[ ongoing updateVersionWith: (versionBlock value: ongoing) ].
	ongoing isUnit
		ifTrue: [ ongoing savePackage ].
	pkgRepository savePackageVersion: ongoing asPackageVersion
]

{ #category : #running }
CGOPackageVersionPublisher >> publishPackages: aListOfPackageNames [
	(self manifestsFor: aListOfPackageNames)
		do: [ :each | self publishPackageVersion: each asOngoingPackageVersion ]
]

{ #category : #running }
CGOPackageVersionPublisher >> run [
	manifests do: [ :manifest |
		self publishPackageVersion: manifest asOngoingPackageVersion ]
]

{ #category : #configuring }
CGOPackageVersionPublisher >> srcRepositories: aListOfRepositoryLocations [ 
	srcRepositories := aListOfRepositoryLocations
]

{ #category : #configuring }
CGOPackageVersionPublisher >> versionBlock: aBlock [
	"a block that will receive the on going package version as parameter and return the version to use to publish this ongoing package"
	versionBlock := aBlock
]
