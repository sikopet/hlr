as yet unclassified
respondWithQuinTuplets: aSubscriber
	| credentials result resultList autn ik ck xres |
	result := 'SendAuthenticationInfoResV3' asAsn1ValueTypedIn: dialogue asn1Model.
	result beSelfExpanding.
	resultList := result authenticationSetList quintupletList.
	credentials := aSubscriber credentials.	"We increment the index for the new batch"
	credentials incrementIndex.
	autn := ByteArray new: 16.
	ik := ByteArray new: 16.
	ck := ByteArray new: 16.
	xres := ByteArray new: 8.
	1 to: 1 do: [ :each | 
		resultList
			addUsing: [ :tuple | 
				| rand |
				rand := '/dev/urandom' asFileReference
					readStreamDo: [ :stream | 
						stream
							binary;
							next: 16 ].
				credentials incrementSeq.
				credentials
					generate: rand
					autn: autn
					ik: ik
					ck: ck
					xres: xres.
				tuple
					rand: rand;
					xres: xres;
					ck: ck;
					ik: ik;
					autn: autn ] ].
	invocation returnResultLast: result.
	dialogue requestTcEnd: false.
	self signalSuccess: 'done'.
	hlr database updateSQN: aSubscriber