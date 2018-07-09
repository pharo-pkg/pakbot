baseline
voyage: spec
	spec
		baseline: 'Voyage'
		with: [ spec
				repository: 'github://pharo-nosql/voyage:master/mc';
				loads: #('memory' 'mongo tests') ]