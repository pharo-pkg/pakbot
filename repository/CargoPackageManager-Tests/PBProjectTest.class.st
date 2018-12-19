Class {
	#name : #PBProjectTest,
	#superclass : #CGOModelTest,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBProjectTest >> testCanGetPackageUnits [
	| units |
	units := ongoingProject packageUnits.
	
	self assert: (units allSatisfy: #isUnit).
]
