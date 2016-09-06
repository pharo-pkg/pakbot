baselines
baseline02: spec
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/demarey/PPM/main'.
		spec 
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/STON/main/' ];
			project: 'VoyageMongo' with: [
				spec
					className: #ConfigurationOfVoyageMongo;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/estebanlm/Voyage/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'bleedingEdge';
					loads: #('REST' );
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/' ];
			project: 'MooseAlgos' with: [
				spec
					className: #ConfigurationOfMooseAlgos;
					versionString: #'bleedingEdge';
					loads: #('Moose-Algos-Graph' );
					repository: 'http://smalltalkhub.com/mc/Moose/MooseAlgos/main/' ].
		spec 
			package: #PackageManager with: [
				spec requires: #('Ston' 'ZincHTTPComponents' 'MooseAlgos' ). ];
			package: #'PackageManager-Spec';
			package: #'PackageManager-TestRessources' with: [
				spec requires: #(#PackageManager #'PackageManager-Spec' 'BabyMock2' ). ];
			package: #'PackageManager-RepositoryBackend' with: [
				spec requires: #(#PackageManager #'PackageManager-TestRessources' 'VoyageMongo' ). ];
			package: #'PackageManager-Tests' with: [
				spec requires: #(#PackageManager #'PackageManager-RepositoryBackend' #'PackageManager-TestRessources' 'Ston' ). ];
			package: #'PackageManager-Repository' with: [
				spec requires: #(#PackageManager #'PackageManager-RepositoryBackend' #'PackageManager-TestRessources' 'ZincHTTPComponents' ). ].
		spec 
			group: 'server' with: #(#PackageManager #'PackageManager-RepositoryBackend' #'PackageManager-Repository' );
			group: 'client' with: #(#PackageManager ). ].
