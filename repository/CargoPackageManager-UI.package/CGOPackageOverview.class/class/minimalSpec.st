specs
minimalSpec
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField ]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]