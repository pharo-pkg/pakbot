"
Datasource to present data of a Pakbot resolution in a FastTree
"
Class {
	#name : #PBResolutionDataSource,
	#superclass : #FTTreeDataSource,
	#category : #'CargoPackageManager-UI-Resolution'
}

{ #category : #initialization }
PBResolutionDataSource >> cellColumn: column row: rowIndex [
	| item |
	
	item := self elementAt: rowIndex.
	^ self newCellFor: item
]

{ #category : #initialization }
PBResolutionDataSource >> iconsFor: item [
	^ item icons
]

{ #category : #initialization }
PBResolutionDataSource >> newCellFor: item [
	| cell |
	cell := FTIndentedCellMorph new.
	cell indentBy: item depth * 16.
	
	cell addMorphBack: (self buttonFor: item).
	(self iconsFor: item data) 
		do: [ :icon | cell addMorphBack: icon asMorph ].
	cell addMorphBack: (self toString: item data) asMorph asReadOnlyMorph.
	^ cell
	

]

{ #category : #initialization }
PBResolutionDataSource >> toString: aResolvedObject [
	^ aResolvedObject nameWithVersion
]
