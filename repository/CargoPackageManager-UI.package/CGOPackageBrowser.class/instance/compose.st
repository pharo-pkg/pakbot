building
compose
	self
		title: 'Package Browser';
		custom:
			(GTInspector new
				noTitle; 
				noActions;
				showFirst: [ :composite |
					self packageListIn: composite ];
				yourself)