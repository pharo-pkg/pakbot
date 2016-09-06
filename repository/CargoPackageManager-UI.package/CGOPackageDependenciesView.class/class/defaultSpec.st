example
defaultSpec
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				newRow: [ :toolbar |
					toolbar
						add: #label;
						add: #addButton width: 40;
						add: #editButton width: 40;
						add: #removeButton width: 40 ]
				height: self toolbarHeight;
				add: #dependencyTree ]
