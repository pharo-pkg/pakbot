private - displaying
morphIconFor: aPart

	^ (self iconForPackage: aPart) asMorph
		 setBalloonText: (self ballonTextFor: aPart)