accessing
dependencyTargetedPackages

	^ resolvedProjectVersion dependencies collect: [ :each | each name ]