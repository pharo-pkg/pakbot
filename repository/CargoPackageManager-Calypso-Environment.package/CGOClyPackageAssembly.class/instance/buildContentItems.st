building items
buildContentItems
	| items |
	items := OrderedCollection new.
	self buildPackageItemsOn: items.
	self buildAssemblyItemsOn: items.
	^ items