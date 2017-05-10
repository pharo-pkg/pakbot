specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField ]
				height: self inputTextHeight;
				newRow: [ :versionRow |
					versionRow 
						add: #versionLabel width: self labelSize;
						add: #versionInputField ]
				height: self inputTextHeight;
				newRow: [ :repositoryRow |
					repositoryRow 
						add: #repositoryLabel width: self labelSize;
						add: #repositoryInputField ]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]