*CargoPackageManager-UI
gtInspectorDescriptionIn: composite
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'Description';
		display: [ self description ];
		act: [ :presentation :selection |
			self updateDescription: presentation text asString printString ]
		icon: GLMUIThemeExtraIcons glamorousSave
		on: $s
		entitled: 'Save'