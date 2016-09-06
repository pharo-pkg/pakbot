*CargoPackageManager-UI
gtInspectorDependenciesIn: composite
	<gtInspectorPresentationOrder: 35>  
	 composite table
		title: 'Dependencies';
		display: [ self dependencies ];
		column: 'Package' evaluated: #name;
		column: 'Constraints' evaluated: #value;
		act: [ :presentation |
			(CGOOngoingPackageUnit on: self) addNewDependency: presentation.
			presentation update ]
		icon: Smalltalk ui icons addIcon
		entitled: 'Add a new dependency';
		
		act: [ :presentation :manifest | 
			presentation rawSelection ifNotNil: [ :selection|
				(CGOOngoingPackageUnit on: self) 
					removeDependency: selection key.
				presentation update ] ]
		icon: Smalltalk ui icons removeIcon
		entitled: 'Remove';
		
		act: [ :presentation :manifest | 
			presentation rawSelection ifNotNil: [ :selection|
				(CGOOngoingPackageUnit on: self) 
					updateDependencyConstraints: selection ].
			presentation update ]
		icon: Smalltalk ui icons editIcon
		entitled: 'Edit dependency';		
		noSelection