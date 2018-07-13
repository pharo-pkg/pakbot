running
tearDown

	#(#'BaselineOfPakbotTestExample'
	#'PakbotTestExample-PackageA'
	#'PakbotTestExample-PackageB'
	#'PakbotTestExample-PackageC'
	#'PakbotTestExample-PackageD')
		do: [ :each | (each asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem ].
		
	MetacelloProjectRegistration registry baselineRegistry removeKey: 'BaselineOfPakbotTestExample' ifAbsent: [].
	
	(MCRepositoryGroup default repositories select: [ :repo | repo class = IceMetacelloRepositoryAdapter])
		detect: [ :repo | repo repository name = 'PakbotTestExample' ]
		ifFound: [ :repo | MCRepositoryGroup default removeRepository: repo ].
		
	IceRepository registry
		detect: [ :repo | repo name = 'PakbotTestExample' ]
		ifFound: [ :repo |repo forget].
	
	super tearDown.
	