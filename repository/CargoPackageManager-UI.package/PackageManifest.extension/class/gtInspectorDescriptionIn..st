*CargoPackageManager-UI
gtInspectorDescriptionIn: composite
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'Description';
		display: [ self description ];
		act: [ :presentation :manifest | 
			(CGOOngoingPackageUnit on: self) 
				updateDescription: presentation text asString printString ]
		icon: GLMUIThemeExtraIcons glamorousSave
		on: $s
		entitled: 'Save'