Class {
	#name : #PBDependencyStatusTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project',
		'dependencyToProject',
		'dependencyToPackage'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #testing }
PBDependencyStatusTest class >> isAbstract [
	^ self = PBDependencyStatusTest 
]

{ #category : #utils }
PBDependencyStatusTest >> createProjectDependency [
	
	^ self subclassResponsibility
]

{ #category : #utils }
PBDependencyStatusTest >> installProject [
	
	self subclassResponsibility 
]

{ #category : #running }
PBDependencyStatusTest >> setUp [
	super setUp.

	project := PBProject named: 'ATestProject'.
	testRegistry register: project.

	dependencyToProject := self createProjectDependency.

	project importPackageNamed: #APackage.
	project addDependency: dependencyToProject
]

{ #category : #tests }
PBDependencyStatusTest >> testProjectDependencyIsNotSatisfied [

	self deny: dependencyToProject isInstalled.
]

{ #category : #tests }
PBDependencyStatusTest >> testProjectDependencyIsSatisfied [

	self installProject.
	self assert: dependencyToProject isInstalled.
]

{ #category : #tests }
PBDependencyStatusTest >> testProjectIsNotUpToDate [

	self deny: project isUpToDate.
	self assert: project hasProblems.
]

{ #category : #tests }
PBDependencyStatusTest >> testProjectIsUpToDate [

	self installProject.
	self assert: project isUpToDate.
	self deny: project hasProblems.
]
