Class {
	#name : #PBPackageRegistryTest,
	#superclass : #TestCase,
	#instVars : [
		'registry'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #initialization }
PBPackageRegistryTest >> setUp [
	registry := PBPackageRegistry new.
]

{ #category : #tests }
PBPackageRegistryTest >> testPackageRegisteredWhenPackageUnitIsAdded [
	| project unit |
	project := PBProject example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry installedPackages size
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectRegisteredWhenPackageUnitIsAdded [
	| project unit |
	project := PBProject example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry registeredProjects size
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectStillRegisteredWhenPackageUnitIsUnregisteredAndSomeOfItsPackageStillInstalled [
	| project unit |
	project := PBProject example.
	project 
		registry: registry;
		repository: PBGitMemoryRepository new.
	unit := project packageUnits anyOne.
	registry register: unit.
	project importPackageNamed: #Unit2. "registers #Unit2"
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects size 
		equals: 1
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectUnregisteredWhenPackageUnitIsUnregistered [
	| project unit |
	project := PBProject example.
	unit := project packageUnits anyOne.
	registry register: unit.
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects isEmpty.
]
