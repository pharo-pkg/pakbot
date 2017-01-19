converting
asPackageVersion
	| assembly |
	assembly := CGOPackageAssembly new.
	CGOPackageAssembly allInstVarNames
		reject: [ :name | #(authors contributors repositories) includes: name ]
		thenDo: [ :instVarName | 
			assembly instVarNamed: instVarName put: (self instVarNamed: instVarName) ].
	^ assembly	