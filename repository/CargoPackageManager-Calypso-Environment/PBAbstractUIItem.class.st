Class {
	#name : #PBAbstractUIItem,
	#superclass : #Object,
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #decorating }
PBAbstractUIItem >> decorate: anItemCellMorph inContext: itemContext [

	self subclassResponsibility
]

{ #category : #testing }
PBAbstractUIItem >> representsItemOfType: aClass [ 

	self subclassResponsibility
]
