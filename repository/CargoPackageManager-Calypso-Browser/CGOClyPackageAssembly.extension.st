Extension { #name : #CGOClyPackageAssembly }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
CGOClyPackageAssembly >> decorateTableCell: anItemCellMorph of: groupItem [
	super decorateTableCell: anItemCellMorph of: groupItem.
			
	anItemCellMorph definitionIcon: #group
]
