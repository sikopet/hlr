as yet unclassified
finishWithRoute: aSubscriber number: aMSISDN
	invocation returnResultLast:
		(ASN1Dictionary new
			at: 'imsi' put: aSubscriber imsiAsTBCD;
			at: 'extendedRoutingInfo' put: 
				(ASN1Dictionary new
					at: 'roamingNumber' put: aMSISDN;
					yourself);
			yourself).

	dialogue requestTcEnd: false.