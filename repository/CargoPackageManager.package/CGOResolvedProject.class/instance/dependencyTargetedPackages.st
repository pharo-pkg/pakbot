accessing
dependencyTargetedPackages

	^ packageVersion dependencies collect: [ :each | each name ]