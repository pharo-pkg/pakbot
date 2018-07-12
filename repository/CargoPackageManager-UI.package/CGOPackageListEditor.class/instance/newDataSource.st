datasource
newDataSource
	
	^ FTEasyListDataSource new 
		elements: self buildRoots;
		display: [ :each | self displayFor: each ];
		icon: [ :each | self morphIconFor: each ];
		yourself