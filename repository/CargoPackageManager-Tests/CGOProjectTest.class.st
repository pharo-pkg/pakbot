Class {
	#name : #CGOProjectTest,
	#superclass : #CGOModelTest,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOProjectTest >> testCanGetPackageUnits [
	| units |
	units := ongoingProject packageUnits.
	
	self assert: (units allSatisfy: #isUnit).
]

{ #category : #tests }
CGOProjectTest >> testEquals [
	| projectA projectB |
	
	projectA := (CGOOngoingProject named: 'A') asCargoProject.
	projectB := (CGOOngoingProject named: 'B') asCargoProject.
	
	self assert: projectA equals: (CGOOngoingProject named: 'A') asCargoProject.
	self assert: projectA ~= projectB.
	
	projectB := (CGOOngoingProject named: 'A') asCargoProject.
	self assert: projectA equals: projectB.
	
	"We assume project version has no impact on project equality"
]
