accessing
buildContentItems
	| items |
	items := OrderedCollection new.
	package dependencies
		do: [ :each | items add: (each asCalypsoItemManagedBy: package manager) ].
	^ items