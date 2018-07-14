Class {
	#name : #CGOMonticelloHostedPackageVersionTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-SCM'
}

{ #category : #tests }
CGOMonticelloHostedPackageVersionTest >> cargoMinimalCD21 [
	^ CGOMonticelloHostedPackageVersion
		repositoryUrl: 'http://smalltalkhub.com/mc/demarey/CargoPackageManager/main'
		packageName: 'CargoPackageManager-Minimal'
		versionString: 'ChristopheDemarey.21'
]

{ #category : #tests }
CGOMonticelloHostedPackageVersionTest >> stonCargoMinimalCD21 [
	^ 'CGOMonticelloHostedPackageVersion{#repository:CGOMonticelloRepository{#repositoryUrl:''http://smalltalkhub.com/mc/demarey/CargoPackageManager/main''},#packageName:#CargoPackageManager-Minimal,#versionString:''ChristopheDemarey.21''}'
]

{ #category : #tests }
CGOMonticelloHostedPackageVersionTest >> testCanGetMCVersionWhenAPackageVersionProvided [
	| repo |
	repo := self cargoMinimalCD21.
	self assert: (repo mcVersion isKindOf: MCVersion)
]

{ #category : #tests }
CGOMonticelloHostedPackageVersionTest >> testCanGetMCVersionWhenRepositoryUrlIsWrong [
	| repo |
	
	repo := CGOMonticelloHostedPackageVersion 
		repositoryUrl: 'http://smalltalkhub.com/mc/foo/bla'
		packageName: 'CargoPackageManager-Minimal'
		versionString: 'ChristopheDemarey.215'.
	
	self 
		should: [ repo mcVersion ]
		raise: MCRepositoryError 
]

{ #category : #tests }
CGOMonticelloHostedPackageVersionTest >> testSTONDeserializationIsOk [
	| mcHostedPackageVersion |
	mcHostedPackageVersion := STON fromString: self stonCargoMinimalCD21.
	self 
		assert: ((mcHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl
]

{ #category : #tests }
CGOMonticelloHostedPackageVersionTest >> testSTONSerializationIsOk [
	| mcHostedPackageVersion |
	mcHostedPackageVersion := self cargoMinimalCD21.
	self
		assert: (STON toString: mcHostedPackageVersion)
		equals: self stonCargoMinimalCD21.
	"test that the original object is not modified"
	self 
		assert: ((mcHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl
]
