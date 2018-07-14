Extension { #name : #CGOClyPackageDependencies }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
CGOClyPackageDependencies >> decorateTableCell: anItemCellMorph of: groupItem [
	super decorateTableCell: anItemCellMorph of: groupItem.
			
	anItemCellMorph definitionIcon: #glamorousBookmark
]
