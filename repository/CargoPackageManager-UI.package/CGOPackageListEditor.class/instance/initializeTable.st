initialization
initializeTable

	packageTree widget
		hideColumnHeaders;
		addColumn: (FTColumn new
						id: 'Name';
						yourself);
		dataSource: self newDataSource