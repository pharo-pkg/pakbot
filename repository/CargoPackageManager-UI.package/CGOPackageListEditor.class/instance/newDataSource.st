datasource
newDataSource
	
	^ FTEasyListDataSource new 
		elements: self buildRoots;
		display: [ :each | self displayStringFor: each ];
		icon: [ :each | self iconForPackage: each ];
		yourself