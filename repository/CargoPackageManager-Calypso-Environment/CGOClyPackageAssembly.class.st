"
I represent an assembly node in a project tree.
I build my children nodes in #buildContentItems.
"
Class {
	#name : #CGOClyPackageAssembly,
	#superclass : #ClyProjectChildItem,
	#instVars : [
		'cargoAssembly'
	],
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #'instance creation' }
CGOClyPackageAssembly class >> of: aProject on: aCGOPackageAssembly [

	^(self project: aProject) 	
		cargoAssembly: aCGOPackageAssembly
]

{ #category : #comparing }
CGOClyPackageAssembly >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ cargoAssembly = anObject cargoAssembly
]

{ #category : #accessing }
CGOClyPackageAssembly >> allPackages [
	^ cargoAssembly allPackageUnits collect: 
		[ :unit |
			project packageNamed: unit packageName ]
]

{ #category : #'building items' }
CGOClyPackageAssembly >> buildAssemblyItemsOn: items [
	| group |
	cargoAssembly assemblies
		do: [ :each | 
			group := CGOClyPackageAssembly of: project on: each.
			items add: group asCalypsoBrowserItem ]
]

{ #category : #'building items' }
CGOClyPackageAssembly >> buildContentItems [
	| items |
	items := OrderedCollection new.
	self buildPackageItemsOn: items.
	self buildAssemblyItemsOn: items.
	^ items
]

{ #category : #'building items' }
CGOClyPackageAssembly >> buildPackageItemsOn: items [
	| item |
	self packages
		do: [ :each | 
			item := ClyBrowserItem named: each name with: each.
			items add: item ]
]

{ #category : #accessing }
CGOClyPackageAssembly >> cargoAssembly [
	^ cargoAssembly
]

{ #category : #accessing }
CGOClyPackageAssembly >> cargoAssembly: anObject [
	cargoAssembly := anObject
]

{ #category : #accessing }
CGOClyPackageAssembly >> cargoPackage [
	^ self cargoAssembly
]

{ #category : #comparing }
CGOClyPackageAssembly >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^super hash bitXor: cargoAssembly hash
]

{ #category : #testing }
CGOClyPackageAssembly >> isEmpty [
	^cargoAssembly isEmpty
]

{ #category : #'as yet unclassified' }
CGOClyPackageAssembly >> items [
	^cargoAssembly parts collect: [:each | 
			each managedByCalypsoUsing: project manager]
]

{ #category : #accessing }
CGOClyPackageAssembly >> name [
	^ cargoAssembly packageName
]

{ #category : #accessing }
CGOClyPackageAssembly >> packages [
	^ cargoAssembly packageNames collect: 
		[ :unitName | project packageNamed: unitName ]
]
