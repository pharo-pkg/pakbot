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
	
	projectA := (PBProject named: 'A') asCargoProject.
	projectB := (PBProject named: 'B') asCargoProject.
	
	self assert: projectA equals: (PBProject named: 'A') asCargoProject.
	self assert: projectA ~= projectB.
	
	projectB := (PBProject named: 'A') asCargoProject.
	self assert: projectA equals: projectB.
	
	"We assume project version has no impact on project equality"
]
