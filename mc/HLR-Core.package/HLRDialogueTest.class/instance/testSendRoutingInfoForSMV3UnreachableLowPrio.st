tests-infoRetrievalPackage
testSendRoutingInfoForSMV3UnreachableLowPrio
	| operationName dialogue  invoke  mwStatus err_message  operation param |
	
	subscriber
		mscNumber: '123';
		clearVlr.
	mwStatus := nil.

	self assert: subscriber isMobileStationNotReachable.
	self assert: subscriber messageWaitingSet isEmpty.

	operationName := 'sendRoutingInfoForSMV3'.
	dialogue := testEndPoint newDialogue.
	operation := dialogue rosOperationNamed: operationName.
	param := operation newArgumentValue 
		at: 'msisdn' put: subscriber msisdn toE164;
		at: 'sm-RP-PRI' put: false;
		at: 'serviceCentreAddress' put: '912343' byteArrayFromHex;
		yourself.
		
	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [:errorMessage | err_message := errorMessage ];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].

	dialogue onInvoke: [:invocation |
				mwStatus := invocation argument privAt: 'mw-Status'].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).

	"TODO.. make sure things return"
	self assert: err_message error originalBindingName = 'absentSubscriberSM'.
	self assert: err_message parameter absentSubscriberDiagnosticSM = 3.
	self assert: (mwStatus includesBit: 'mnrf-Set').
	self assert: (subscriber messageWaitingSet anySatisfy: [:assoc | assoc value = '3234'])