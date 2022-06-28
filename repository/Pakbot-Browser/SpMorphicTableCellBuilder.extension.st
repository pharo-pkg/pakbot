Extension { #name : #SpMorphicTableCellBuilder }

{ #category : #'*Pakbot-Browser' }
SpMorphicTableCellBuilder >> visitDropListColumn: aDropListTableColumn [

	| presenter morph |
	presenter := SpDropListPresenter new
		             addStyle: 'table';
						startWithoutSelection;
		             items: (aDropListTableColumn readObject: self item);
		             yourself.
 
	aDropListTableColumn display ifNotNil: [ 
		presenter display: (aDropListTableColumn display) ].
	aDropListTableColumn selectedItemChangedAction ifNotNil: [ 
		presenter selection whenChangedDo: [ :selection | 
			aDropListTableColumn selectedItemChangedAction
				cull: self item
				cull: (selection ifNotNil: [ presenter selectedItem ]) ] ].

	morph := presenter build.
	presenter adapter applyStyle: morph.

	self addCellMorph: morph column: aDropListTableColumn.
]
