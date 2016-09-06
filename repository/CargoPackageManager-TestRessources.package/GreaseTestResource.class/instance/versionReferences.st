data
versionReferences
	"This method answers a collection of unique references in the order they should be sorted. It includes two different packages (Gofer-Foo, Gofer-Bar), linear series of packages (Gofer-Foo-lr.1, Gofer-Foo-lr.2, Gofer-Foo-lr.4), packages with a branch (Gofer-Bar.branch-lr.1,Gofer.branch-Bar-lr.2), and packages with the same version but different authors (Gofer-Bar-jf.1, Gofer-Bar-lr.1)."

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