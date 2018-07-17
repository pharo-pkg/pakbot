Class {
	#name : #PBAbstractCalypsoTest,
	#superclass : #CGOAbstractTest,
	#instVars : [
		'systemEnvironment',
		'navigationEnvironment',
		'scope',
		'registry'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBAbstractCalypsoTest >> setUp [
	registry := CGOPackageRegistry new.
	
	systemEnvironment := ClySystemEnvironment new.
	systemEnvironment projectManager registerPackageManager: (CGOCalypsoPackageManager forRegistry: registry). 
	
	navigationEnvironment := ClyNavigationEnvironment overSystemEnvironment: systemEnvironment.
	scope := navigationEnvironment systemScope.

]
