building items
buildPackageItemsOn: items
	| item |
	self packages
		do: [ :each | 
			item := ClyEnvironmentItem named: each name with: each.
			item scope: ClyPackageScope.
			items add: item ]