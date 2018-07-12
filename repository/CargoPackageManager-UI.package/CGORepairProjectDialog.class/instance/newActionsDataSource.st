initialization
newActionsDataSource

	^ FTEasyListDataSource new
		elements: (CGORepairProjectAction allAvailableFor: project);
		display: [ :each | each name ];
		icon: [ :each | self iconNamed: each iconName ];
		yourself