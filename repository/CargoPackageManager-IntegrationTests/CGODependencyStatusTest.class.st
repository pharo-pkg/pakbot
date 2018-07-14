Class {
	#name : #CGODependencyStatusTest,
	#superclass : #CGOAbstractTest,
	#instVars : [
		'registry',
		'project',
		'dependencyToProject',
		'dependencyToPackage'
	],
	#category : 'CargoPackageManager-IntegrationTests'
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
	registry := CGOPackageRegistry new.
	project := CGOOngoingProject named: 'ATestProject'.
	registry register: project.

	dependencyToProject := self createProjectDependency.

	project newPackageUnit: #APackage.
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
