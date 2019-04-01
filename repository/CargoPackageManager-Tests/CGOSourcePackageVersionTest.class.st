Class {
	#name : #CGOSourcePackageVersionTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-SCM'
}

{ #category : #tests }
CGOSourcePackageVersionTest >> testCanInstantiateGitHostedPackageVersionFromAGitRepository [
	| sourcePackageVersion |
	
	sourcePackageVersion := CGOSourcePackageVersion 
		repository: 	PBGitRepository example
		packageName: 'Foo'.
	
	self 
		assert: sourcePackageVersion class 
		equals: CGOGitHostedPackageVersion 
]

{ #category : #tests }
CGOSourcePackageVersionTest >> testCanInstantiateMonticelloHostedPackageVersionFromAMonticelloRepository [
	| sourcePackageVersion |
	
	sourcePackageVersion := CGOSourcePackageVersion 
		repository: 	CGOMonticelloRepository example
		packageName: 'Foo'.
	
	self 
		assert: sourcePackageVersion class 
		equals: CGOMonticelloHostedPackageVersion
]
