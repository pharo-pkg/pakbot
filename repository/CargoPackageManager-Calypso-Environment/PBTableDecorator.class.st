Class {
	#name : #PBTableDecorator,
	#superclass : #ClyTableDecorator,
	#category : #'CargoPackageManager-Calypso-Environment-Decorators'
}

{ #category : #decoration }
PBTableDecorator class >> browserDecorationStrategy [
	<classAnnotation>
	"I apply on all the contexts, as I am filtered by the browser item" 
	
	^ ClyTableDecorationStrategy for: PBAbstractUIItem asCalypsoItemContext
]

{ #category : #decoration }
PBTableDecorator class >> decorateMainTableCell: anItemCellMorph inContext: itemContext [

	anItemCellMorph actualObject decorate: anItemCellMorph inContext: itemContext

]

{ #category : #decoration }
PBTableDecorator class >> priority [
	^200
]

{ #category : #decoration }
PBTableDecorator class >> wantsDecorateTableCellOf: aDataSourceItem [
		
	^ aDataSourceItem browserItem hasOwnDecoration
]
