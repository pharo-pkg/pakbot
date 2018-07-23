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
