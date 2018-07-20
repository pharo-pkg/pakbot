Class {
	#name : #CGOPackageRegistryTest,
	#superclass : #TestCase,
	#instVars : [
		'registry'
	],
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #initialization }
CGOPackageRegistryTest >> setUp [
	registry := CGOPackageRegistry new.
]

{ #category : #tests }
CGOPackageRegistryTest >> testPackageRegisteredWhenPackageUnitIsAdded [
	| project unit |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry installedPackages size
		equals: 1.
]

{ #category : #tests }
CGOPackageRegistryTest >> testProjectRegisteredWhenPackageUnitIsAdded [
	| project unit |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry registeredProjects size
		equals: 1.
]

{ #category : #tests }
CGOPackageRegistryTest >> testProjectStillRegisteredWhenPackageUnitIsUnregisteredAndSomeOfItsPackageStillInstalled [
	| project unit unit2 |
	project := CGOOngoingProject example.
	project registry: registry.
	unit := project packageUnits anyOne.
	registry register: unit.
	unit2 := project importPackageNamed: #Unit2. "registers #Unit2"
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects size 
		equals: 1
]

{ #category : #tests }
CGOPackageRegistryTest >> testProjectUnregisteredWhenPackageUnitIsUnregistered [
	| project unit |
	project := CGOOngoingProject example.
	unit := project packageUnits anyOne.
	registry register: unit.
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects isEmpty.
]
