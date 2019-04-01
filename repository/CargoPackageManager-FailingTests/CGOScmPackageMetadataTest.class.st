Class {
	#name : #CGOScmPackageMetadataTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-FailingTests-PackageRepository'
}

{ #category : #'test data' }
CGOScmPackageMetadataTest >> greaseRepository [
	^ (PBGitRepositoryCreator repositoryCreatorWithUrl: 'https://github.com/demarey/Grease-cargo.git')
		subdirectory: 'repository';
		create
]

{ #category : #'test data' }
CGOScmPackageMetadataTest >> greaseSCMPackageMetadata [
	^ CGOScmPackageMetadata new
		registerProjectFromSourceRepository: self greaseRepository at: #Grease;
		yourself
]

{ #category : #tests }
CGOScmPackageMetadataTest >> testCanGetLatestVersionOfVirtualPackage [
	| repository package |
	repository := self greaseSCMPackageMetadata.
	(repository instVarNamed: 'packageVersions') 
		add: (CGOVirtualPackageVersion fromString: 'Grease-Slime@1.0').
		
	package := repository 
		latestVersionOfPackage: 'Grease-Slime'
		suitableForEnvironment: #('pharo5.x').
	self
		assert: package name
		equals: 'Grease-Slime@1.0.0'
]
