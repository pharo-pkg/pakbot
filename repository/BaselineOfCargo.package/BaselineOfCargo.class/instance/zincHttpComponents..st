baseline
zincHttpComponents: spec
	spec
		project: 'ZincHTTPComponents'
		with: [ spec
				className: #ConfigurationOfZincHTTPComponents;
				versionString: #bleedingEdge;
				loads: #('REST');
				repository:
					'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/' ]