data
packageVersions
	"create Cargo package version for theses packages using a MCDictionary repository"

	^ #( 'GoferBar.branch-lr.1'
		'GoferBar.branch-lr.2'
		'GoferBar-jf.1'
		'GoferBar-lr.1'
		'GoferFoo-lr.1'
		'GoferFoo-lr.2'
		'GoferFoo-lr.4'
		'Grease-Core-JohanBrichau.94'
		'Grease-Core-JohanBrichau.83'
		'Grease-Pharo30-Core-pmm.11'
		'Grease-Pharo30-Core-JohanBrichau.16'
		'Grease-Pharo40-Slime-JohanBrichau.3'
		'Grease-Slime-pmm.29'
		 ) 
		collect: [ :each |	CGOVersionReference named: each ]