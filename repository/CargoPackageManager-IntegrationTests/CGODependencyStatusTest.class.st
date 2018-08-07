Class {
	#name : #CGODependencyStatusTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'dependencyToProject',
		'dependencyToPackage'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #testing }
CGODependencyStatusTest class >> isAbstract [
	^ self = CGODependencyStatusTest 
]

{ #category : #utils }
CGODependencyStatusTest >> createProjectDependency [
	
	^ self subclassResponsibility
]

{ #category : #utils }
CGODependencyStatusTest >> installProject [
	
	self subclassResponsibility 
]

{ #category : #running }
CGODependencyStatusTest >> setUp [
	super setUp.

	project := PBProject named: 'ATestProject'.
	testRegistry register: project.

	dependencyToProject := self createProjectDependency.

	project importPackageNamed: #APackage.
	project addDependency: dependencyToProject
]

{ #category : #tests }
CGODependencyStatusTest >> testProjectDependencyIsNotSatisfied [

	self deny: dependencyToProject isInstalled.
]

{ #category : #tests }
CGODependencyStatusTest >> testProjectDependencyIsSatisfied [

	self installProject.
	self assert: dependencyToProject isInstalled.
]

{ #category : #tests }
CGODependencyStatusTest >> testProjectIsNotUpToDate [

	self deny: project isUpToDate.
	self assert: project hasProblems.
]

{ #category : #tests }
CGODependencyStatusTest >> testProjectIsUpToDate [

	self installProject.
	self assert: project isUpToDate.
	self deny: project hasProblems.
]
