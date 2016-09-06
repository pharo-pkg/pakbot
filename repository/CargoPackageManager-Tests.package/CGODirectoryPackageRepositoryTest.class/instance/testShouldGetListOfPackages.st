tests
testShouldGetListOfPackages
	self 
		assertCollection: repository packages
		hasSameElements: #(#GoferBar #'Grease-Core' #'Grease-Pharo30-Core' #'Grease-Pharo30-Slime' #'Grease-Pharo40-Slime')