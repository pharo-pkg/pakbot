data - cargo package versions
cargoFakePackageVersions
	"fake package versions"
	^ #( 'GoferBar@1-branch-lr'
		'GoferBar@2-branch-lr'
		'GoferBar@1'
		'GoferBar@1.1'
		'GoferBar@2'
		'GoferBar@4'
		'Grease-Core@1.1.12'
	) collect: [ :each |
		 CGOPackageUnit fromString: each ].
