initialization
initializeTable

	packageTree widget
		addColumn: (FTColumn new
						id: 'Name';
						yourself);
		dataSource: self newDataSource