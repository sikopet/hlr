access
mscNumberAsE164
	"We need to BCD encode the MSISDN number and append a byte"
	^(#(16r91) , (GSMNumberDigits encodeFrom: mscNumber)) asByteArray hex