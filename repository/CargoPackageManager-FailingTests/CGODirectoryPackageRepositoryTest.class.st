Class {
	#name : #CGODirectoryPackageRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'packageNames',
		'temporaryPath',
		'emptyRepository',
		'greaseRepository'
	],
	#category : 'CargoPackageManager-FailingTests-PackageRepository'
}

{ #category : #accessing }
CGODirectoryPackageRepositoryTest class >> resources [
	^ { GreaseTestResource }
]

{ #category : #running }
CGODirectoryPackageRepositoryTest >> setUp [
	super setUp.
	greaseRepository := GreaseTestResource current cargoLocalRepository.
	greaseRepository savePackageVersion: PBProject example asCargoProject. "ensure a project dos not introduce mess in a package repository"
	emptyRepository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	temporaryPath := '/tmp/cargo-repo-test' asFileReference.
]

{ #category : #running }
CGODirectoryPackageRepositoryTest >> tearDown [
	super tearDown.
	temporaryPath ensureDeleteAll.
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testCanGetLatestVersionOfVirtualPackage [
	| package |
	package := greaseRepository latestVersionOfPackage: 'Grease-Slime' suitableForEnvironment: #('pharo5.x').
	self
		assert: package name
		equals: 'Grease-Slime@1.0.0'
]

{ #category : #'repository-specific' }
CGODirectoryPackageRepositoryTest >> testCreateRepositoryShouldCreateDirectoryFromFileName [

	self deny: temporaryPath asFileReference isDirectory.
	CGODirectoryPackageRepository newInDirectory: temporaryPath fullName.
	self assert: temporaryPath asFileReference isDirectory
]

{ #category : #'repository-specific' }
CGODirectoryPackageRepositoryTest >> testCreateRepositoryShouldCreateDirectoryFromFileReference [	

	self deny: temporaryPath asFileReference isDirectory.
	CGODirectoryPackageRepository newInDirectory: temporaryPath asFileReference.	
	self assert: temporaryPath asFileReference isDirectory
]

{ #category : #'repository-specific' }
CGODirectoryPackageRepositoryTest >> testCreateRepositoryShouldFailIfDirectoryIsFile [

	self deny: temporaryPath asFileReference isDirectory.
	temporaryPath asFileReference writeStream close.
	
	self should: [CGODirectoryPackageRepository newInDirectory: temporaryPath fullName] raise: FileExists
]

{ #category : #'repository-specific' }
CGODirectoryPackageRepositoryTest >> testCreateRepositoryShouldWorkOkIfDirectoryAlreadyExists [

	temporaryPath asFileReference ensureCreateDirectory.
	
	CGODirectoryPackageRepository newInDirectory: temporaryPath asFileReference.
	self assert: temporaryPath asFileReference isDirectory
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchExactPackageVersionShouldFailIfAbsentPackageName [
	| packageName version |
	
	packageName := 'Grease-Core-Not-There'.
	version := '1.1.13'.
	
	self should: [ greaseRepository fetch: packageName version: version ] raise: CGOPackageNotFoundError
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchExactPackageVersionShouldFailIfAbsentVersion [
	| packageName version |
	
	packageName := 'Grease-Core'.
	version := '1.1.13-absentVersion'.
	
	self should: [ greaseRepository fetch: packageName version: version ] raise: CGOPackageVersionNotFoundError
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchExactPackageVersionShouldReturnPackageVersionIfPresent [
	| packageName version pkgVersion |
	
	packageName := 'Grease-Core'.
	version := '1.1.13'.
	
	pkgVersion := greaseRepository fetch: packageName version: version.
	
	self assert: (pkgVersion isKindOf: CGOPackageVersion).
	self assert: pkgVersion packageName equals: packageName.
	self assert: pkgVersion version equals: version asSemanticVersion.

]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchExactVirtualPackageVersionShouldFailIfAbsentVersion [
	| packageName version |
	
	packageName := 'Grease-Slime'.
	version := '2.0-absentVersion'.
	
	self 
		should: [ greaseRepository fetchVirtual: packageName version: version ]
		raise: CGOPackageVersionNotFoundError
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchExactVirtualPackageVersionShouldFailIfAbsentVirtualPackageName [
	| packageName version |
	
	packageName := 'Grease-Slime-Not-There'.
	version := '1'.
	
	self 
		should: [ greaseRepository fetch: packageName version: version ]
		raise: CGOPackageNotFoundError
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchExactVirtualPackageVersionShouldReturnVirtualPackageVersionIfPresent [
	| packageName version pkgVersion |
	
	packageName := 'Grease-Slime'.
	version := '1'.
	
	pkgVersion := greaseRepository fetchVirtual: packageName version: version.
	
	self assert: (pkgVersion isKindOf: CGOVirtualPackageVersion).
	self assert: pkgVersion packageName equals: packageName.
	self assert: pkgVersion version equals: version asSemanticVersion.

]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchVersionsShouldReturnAllVersionsIfPackageExists [
	self 
		assertCollection: (greaseRepository versionStringsOf: 'grease-core')
		hasSameElements:  #('grease-core@1.1.12' 'grease-core@1.1.13')
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchVersionsShouldReturnEmptyListIfPackageDoesNotExist [

	self assert: (greaseRepository versionStringsOf: 'Unexistent') equals: #()
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testFetchVersionsShouldReturnsEmptyListIfPackageIsVirtual [
	
	self assert: (greaseRepository versionStringsOf: 'Grease-Slime') isEmpty
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testGetPackagesShouldReturnAllPackageNamesInRepository [
	
	self 
		assertCollection: greaseRepository packageNames
		hasSameElements: #(#myproject #goferbar #'grease-core' #'grease-pharo30-core' #'grease-pharo30-slime' #'grease-pharo40-slime')
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testGetPackagesShouldReturnEmptyListFromEmptyRepository [
	
	self assert: emptyRepository packageNames isEmpty
]

{ #category : #tests }
CGODirectoryPackageRepositoryTest >> testPackagesProvidingAFeatureForNoPlatformAttributesShouldBeEmpty [

	self assert: (greaseRepository packagesProviding: 'Grease-Slime' version: '1.0' forEnvironment: "No platform atributes" #()) isEmpty.
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSaveDevelopmentVersionShouldOverrideOldVersion [

	emptyRepository savePackageVersion: (GreaseTestResource current greasecore1_1_13devWithDescription: 'old').
	emptyRepository savePackageVersion: (GreaseTestResource current greasecore1_1_13devWithDescription: 'new').
	
	self assert: (emptyRepository fetch: 'grease-core' version: '1.1.13-dev') description equals: 'new'
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionCanSaveCargoProject [
	| project |

	project := PBProject example asCargoProject.

	emptyRepository savePackageVersion: project.
	
	self assert: (emptyRepository rootDirectory / project packageName asLowercase / project name asLowercase) isFile.
]

{ #category : #'repository-specific' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionShouldCreateDirectoryPerPackage [
	| pkgVersion |
	
	pkgVersion := GreaseTestResource current greasecore1_1_13.
	
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository rootDirectory / pkgVersion packageName asLowercase) isDirectory
]

{ #category : #'repository-specific' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionShouldCreateVersionFile [
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.
	
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository rootDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase) isFile.

]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionShouldFailIfVersionAlreadyExists [
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.

	emptyRepository savePackageVersion: pkgVersion.
	self should: [emptyRepository savePackageVersion: pkgVersion] raise: CGOPackageVersionAlreadyExistsError.
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionShouldNotFailIfPackageAlreadyExistsButVersionDoesNot [
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.

	emptyRepository savePackageVersion: pkgVersion.
	emptyRepository savePackageVersion: GreaseTestResource current greasepharo30core1_1_13
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionShouldSaveIfPackageVersionNotPresent [
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository rootDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase) isFile.

]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionWhenPackageProvidesVirtualPackageShouldUpdateVirtualPackageIndex [
	| pkgVersion index |

	pkgVersion := GreaseTestResource current greasepharo40slime1_1_13.
	emptyRepository savePackageVersion: pkgVersion.
	index := (emptyRepository virtualIndexesDirectory / 'Grease-Slime' asLowercase / 'Grease-Slime@1.0.0' asLowercase).

	self assert: index isFile.
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testSavePackageVersionWhenPackageVersionIsAVirtualPackage [
	| pkgVersion |

	pkgVersion := CGOVirtualPackageVersion example.
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository virtualDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase) isFile.
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testShouldGetLatestPackageAvalaibleWhenAskingLatestVersion [
	| package |
	package := greaseRepository latestVersionOfConcretePackage: 'grease-core' suitableForEnvironment: #().
	
	self
		assert: package name
		equals: 'grease-core@1.1.13'
]

{ #category : #'tests - saving' }
CGODirectoryPackageRepositoryTest >> testShouldGetSpecificPackagesProvidingAVirtualPackageWhenPlatformAttributeSpecified [
	| packages |
	packages := greaseRepository packagesProviding: 'Grease-Slime' version: '1.0' asSemanticVersion forEnvironment: #('pharo5.x').
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Pharo40-Slime@1.1.13')
]
