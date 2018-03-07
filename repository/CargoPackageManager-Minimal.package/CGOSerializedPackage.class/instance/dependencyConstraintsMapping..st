serialization
dependencyConstraintsMapping: aDependency
	^ (aDependency constraints collect: #asString)
			ifEmpty: [ #() ]