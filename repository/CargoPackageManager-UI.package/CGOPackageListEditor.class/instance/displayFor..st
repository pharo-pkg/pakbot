private - displaying
displayFor: aDependency

	^ aDependency displayString asMorph
		setBalloonText: (self ballonTextFor: aDependency);
		yourself