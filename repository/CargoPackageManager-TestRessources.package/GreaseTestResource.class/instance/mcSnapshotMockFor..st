building
mcSnapshotMockFor: aPackageName
	^ MCSnapshot
		fromDefinitions:
			(Array
				with: (MCOrganizationDefinition categories: (Array with: aPackageName asSymbol))
				with:
					(MCClassDefinition
						name: (aPackageName copyWithout: $-) asSymbol
						superclassName: #Object
						category: aPackageName asSymbol
						instVarNames: #()
						comment: ''))