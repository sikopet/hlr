test-supplementary-services
testActivateSSNoVlrNumber
	| operationName dialogue  invoke invokeResult param invocations |

	invocations := 0.
	param := ASN1Dictionary new
		at: 'ss-Code' put: SSData callWaiting asByteArray;
		at: 'basicService' put: (ASN1Dictionary new
					at: 'teleservice' put: #[16r10];
					yourself);
		yourself.

	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:invocation |
				invocations := invocations + 1.
				invocation returnResultLast: nil.
				diag requestTcContinue]].

	operationName := 'activateSS'.
	dialogue := testEndPoint newDialogue.
	invoke := dialogue requestTcInvokeNamed: operationName parameters:  param class: 1 timeout: 5.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [:result |  invokeResult := result].
	dialogue
		requestTcBeginDestinationAddress: self imsiAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName)
		userInformation: (ASN1Array new 
			add: (
				ASN1Dictionary new
					at: 'map-open' put: (ASN1Dictionary new
						at: 'destinationReference' put: subscriber imsi toE212;
						at: 'originationReference' put: '0815' toE164;
						yourself);
					at: 'oid' put: '0.4.0.0.1.1.1.1';
					yourself); 
			yourself).

	self deny: invokeResult isNil.
	self assert: invocations equals: 0.