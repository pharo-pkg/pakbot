actions
updateProvisions
	| provisions |
	provisions := (Character space split: provisionsInputField text) 
		collect: #asSymbol as: Array.
	ongoingPackageUnit provisions: provisions