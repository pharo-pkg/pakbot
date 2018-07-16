Class {
	#name : #CGOProjectTableDecorator,
	#superclass : #ClyTableDecorator,
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #decoration }
CGOProjectTableDecorator class >> browserDecorationStrategy [
	<classAnnotation>
	
	^ClyTableDecorationStrategy for: PBProjectContextOfFullBrowser
]

{ #category : #decoration }
CGOProjectTableDecorator class >> decorateMainTableCell: anItemCellMorph inContext: itemContext [

	anItemCellMorph actualObject decorateTableCell: anItemCellMorph inContext: itemContext

]

{ #category : #decoration }
CGOProjectTableDecorator class >> priority [
	^200
]

{ #category : #decoration }
CGOProjectTableDecorator class >> wantsDecorateTableCellOf: aDataSourceItem [
		
	self flag:#todo.
	^aDataSourceItem actualObject isKindOf: PBProjectBrowserItem
]
