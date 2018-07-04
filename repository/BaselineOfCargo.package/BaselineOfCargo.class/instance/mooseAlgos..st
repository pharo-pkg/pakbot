baseline
mooseAlgos: spec
	spec
		project: 'MooseAlgos'
		with: [ spec
				className: #ConfigurationOfMooseAlgos;
				versionString: #bleedingEdge;
				loads: #('Moose-Algos-Graph');
				repository: 'http://smalltalkhub.com/mc/Moose/MooseAlgos/main/' ]