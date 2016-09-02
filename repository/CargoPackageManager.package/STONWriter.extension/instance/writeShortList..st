*CargoPackageManager
writeShortList: collection
	self with: collection do: [ 
		self encodeList: collection ]