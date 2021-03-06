baselines
baseline1: spec
	<version: '1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/osmocom/HomeLocationRegister/main'.
		spec 
			project: 'Phexample' with: [
				spec
					className: #ConfigurationOfPhexample;
					versionString: '1.2';
					repository: 'http://smalltalkhub.com/mc/Phexample/Phexample/main' ];
			project: 'ASN1' with: [
				spec
					className: #ConfigurationOfASN1;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/NorbertHartl/ASN1/main' ];
			project: 'VoyageMongo' with: [
				spec
					className: #ConfigurationOfVoyageMongo;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/estebanlm/Voyage/main' ];
			project: 'RFB' with: [
				spec
					className: #ConfigurationOfRFB;
					versionString: '0.63';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/RFB/main' ];
			project: 'TCAP' with: [
				spec
					className: #ConfigurationOfTCAP;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/TCAP/main/' ];
			project: 'CDR' with: [
				spec
					className: #ConfigurationOfCDR;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/osmocom/ChargingDataRecord/main/' ].
		spec 
			package: 'HLR-Core' with: [
				spec requires: #('TCAP' 'CDR' 'ASN1' ). ];
			package: 'HLR-Camel' with: [
				spec requires: #('HLR-Core' ). ];
			package: 'HLR-Voyage' with: [
				spec requires: #('HLR-Core' 'VoyageMongo' ). ].
		spec 
			group: 'core' with: #('HLR-Core' );
			group: 'camel' with: #('HLR-Camel' );
			group: 'default' with: #('core' 'camel' 'HLR-Voyage' 'RFB' ). ].
