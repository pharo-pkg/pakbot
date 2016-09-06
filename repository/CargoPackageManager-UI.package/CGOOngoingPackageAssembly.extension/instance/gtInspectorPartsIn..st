*CargoPackageManager-UI
gtInspectorPartsIn: composite
	<gtInspectorPresentationOrder: 35>  
	 composite table
		title: 'Parts';
		display: [ self parts ];
		column: 'Package' evaluated: #name;
		column: 'Version' evaluated: #value;
		act: [ :presentation |
			self addNewPart: presentation.
			presentation update ]
		icon: Smalltalk ui icons addIcon
		entitled: 'Add a new part';
		
		act: [ :presentation :inspectedObject |
			self removePart: presentation rawSelection key.
			presentation update ]
		icon: Smalltalk ui icons removeIcon
		entitled: 'Remove';
		
		act: [ :presentation :inspectedObject | 
			self updateParts: presentation rawSelection.
			presentation update ]
		icon: Smalltalk ui icons editIcon
		entitled: 'Edit parts';
		
		noSelection