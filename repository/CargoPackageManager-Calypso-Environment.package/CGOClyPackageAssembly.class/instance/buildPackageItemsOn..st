building items
buildPackageItemsOn: items
	| item |
	self packages
		do: [ :each | 
			item := ClyBrowserItem named: each name with: each.
			items add: item ]