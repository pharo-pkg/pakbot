specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				newRow: [ :toolbar |
					toolbar
						add: #label;
						add: #addButton;
						add: #editButton;
						add: #removeButton ]
				height: self toolbarHeight;
				add: #packageTree ]
