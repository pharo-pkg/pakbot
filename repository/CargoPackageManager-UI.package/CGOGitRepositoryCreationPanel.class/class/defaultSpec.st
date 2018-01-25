specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #newRepositoryButton height: self toolbarHeight;
				add: #cloneRepositoryButton height: self toolbarHeight;
				add: #addLocalRepositoryButton height: self toolbarHeight ]