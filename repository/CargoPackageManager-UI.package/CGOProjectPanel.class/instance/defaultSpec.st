specs
defaultSpec

	^ SpecLayout composed
		newColumn: [ :col |
		 col
			newRow: [ :row | row add: #projectStatus ] height: (projectStatus requiredHeight);
			newRow: [ :row | 
				row
					add: #overview;
					add: #dependencies ]]