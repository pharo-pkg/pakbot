Class {
	#name : #PMPackageDependenciesCheckerTest,
	#superclass : #TestCase,
	#instVars : [
		'imageDependencies'
	],
	#category : 'CargoPackageManager-Utils-FailingTests'
}

{ #category : #tests }
PMPackageDependenciesCheckerTest >> testCanGetImageDependencies [
	| dependencyMap |
	dependencyMap := PMPackageDependenciesChecker new imageDependencies.
	
	self 
		assert: dependencyMap size
		equals: RPackage organizer packages size.
	
	self assert: dependencyMap keys anyOne isSymbol.
	self
		shouldnt: [ RPackage organizer packageNamed: dependencyMap keys anyOne ]
		raise: KeyNotFound.
	self assert: dependencyMap values anyOne isCollection
	
	.dependencyMap inspect
]

{ #category : #tests }
PMPackageDependenciesCheckerTest >> testGroupCandidates [
	| candidates |
	candidates := PMPackageDependenciesChecker new 
		buildImageDependencyMap;
		groupCandidates.
	candidates inspect
	
	
]

{ #category : #tests }
PMPackageDependenciesCheckerTest >> testTopGroups [
	| top |
	^ self skip.
	"top := PMPackageDependenciesChecker new 
		buildImageDependencyMap;
		topGroups.
	top inspect"
	
	
]
