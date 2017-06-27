specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ :column |
			column
				newRow: [ :provisionsRow |
					provisionsRow 
						add: #provisionsLabel width: self labelSize;
						add: #provisionsInputField ]
				height: self inputTextHeight;
				newRow: [ :platformRow |
					platformRow 
						add: #platformRequirementsLabel width: 130;
						add: #editPlatformRequirementsButton width: 40;
						add: #platformRequirementWidget ]
				height: self inputTextHeight;
				add: #dependenciesView";
				newRow: [ :fileRow |
					fileRow 
						add: #fileLabel width: self labelSize;
						add: #fileInputField ]
				height: self inputTextHeight" ]