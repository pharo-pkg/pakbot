specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField;
						add: #browseButton width: 24 ]
				height: self inputTextHeight;
				newRow: [ :versionRow |
					versionRow 
						add: #versionLabel width: self labelSize;
						add: #versionInputField ]
				height: self inputTextHeight;
				newRow: [ :repositoryRow |
					repositoryRow 
						add: #repositoryLabel width: self labelSize;
						add: #repositoryValueLabel;
						add: #repositoryEditButton  width: 25]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]