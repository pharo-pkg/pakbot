set-up
setUp
	"This method builds a fake repository with the version references from #setUpVersionReferences."
	| packages |
	super setUp.
	packages := Dictionary new.
	mcRepository := MCDictionaryRepository new.
	self versionReferences
		do: [ :reference | mcRepository basicStoreVersion: (self mcVersionFor: reference packages: packages) ]