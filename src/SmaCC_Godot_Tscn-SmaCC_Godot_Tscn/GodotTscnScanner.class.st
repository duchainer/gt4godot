Class {
	#name : #GodotTscnScanner,
	#superclass : #SmaCCScanner,
	#category : #'SmaCC_Godot_Tscn-SmaCC_Godot_Tscn'
}

{ #category : #'generated-initialization' }
GodotTscnScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(31 'false' 15) #(31 'true' 15))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GodotTscnScanner >> emptySymbolTokenId [
	^ 81
]

{ #category : #generated }
GodotTscnScanner >> errorTokenId [
	^ 82
]

{ #category : #generated }
GodotTscnScanner >> scan1 [
	[ self recordMatch: #(13).
	self step.
	currentCharacter == Character lf ] whileTrue.
	currentCharacter == Character cr ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan10 [
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan12 ].
	('+-' includes: currentCharacter) ifTrue: [ ^ self scan11 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan11 [
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan12 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan12 [
	[ self recordMatch: #(20).
	self step.
	currentCharacter == $_ ifTrue: [ ^ self scan11 ].
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan13 [
	[ self recordMatch: #(23).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_
		ifTrue: [ self step.
			currentCharacter isDigit ifTrue: [ ^ self scan13 ].
			^ self reportLastMatch ].
	currentCharacter isDigit ] whileTrue.
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan14 [
	self recordMatch: #(31).
	self step.
	currentCharacter == $+ ifTrue: [ ^ self scan11 ].
	currentCharacter == $- ifTrue: [ ^ self scan15 ].
	currentCharacter isDigit ifTrue: [ ^ self scan16 ].
	(currentCharacter == $/
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan15 [
	self recordMatch: #(31).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan16 ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan16 [
	[ self recordMatch: #(20 31).
	self step.
	currentCharacter == $_ ifTrue: [ ^ self scan15 ].
	currentCharacter isDigit ] whileTrue.
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan17 [
	[ self recordMatch: #(23 31).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_ ifTrue: [ ^ self scan18 ].
	currentCharacter isDigit ] whileTrue.
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	((currentCharacter between: $- and: $/)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan18 [
	self recordMatch: #(31).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan17 ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan19 [
	self recordMatch: #(31).
	(self scanForString: 'nf')
		ifTrue: [ self recordMatch: #(21 31).
			self step ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $/ and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan2 [
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan20 [
	self recordMatch: #(31).
	self step.
	currentCharacter == $a
		ifTrue: [ self recordMatch: #(31).
			self step.
			currentCharacter == $n
				ifTrue: [ self recordMatch: #(22 31).
					self step ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
				ifTrue: [ [ self recordMatch: #(31).
					self step.
					currentCharacter == $-
						or: [ (currentCharacter between: $/ and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $/ and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $b and: $z ] ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan21 [
	self recordMatch: #(31).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan22 ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan22 [
	self recordMatch: #(31).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan23 ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan23 [
	self recordMatch: #(31).
	self step.
	currentCharacter == $-
		ifTrue: [ self recordMatch: #(31).
			self step.
			currentCharacter isDigit
				ifTrue: [ self recordMatch: #(31).
					self step.
					currentCharacter isDigit
						ifTrue: [ self recordMatch: #(29 31).
							self step.
							currentCharacter == Character space
								ifTrue: [ self step.
									currentCharacter isDigit
										ifTrue: [ self step.
											currentCharacter isDigit
												ifTrue: [ self step.
													currentCharacter == $: ifTrue: [ ^ self scan24 ] ] ].
									^ self reportLastMatch ].
							('Tt' includes: currentCharacter)
								ifTrue: [ self recordMatch: #(31).
									self step.
									currentCharacter isDigit
										ifTrue: [ self recordMatch: #(31).
											self step.
											currentCharacter isDigit
												ifTrue: [ self recordMatch: #(31).
													self step.
													currentCharacter == $: ifTrue: [ ^ self scan24 ].
													(currentCharacter == $-
														or: [ (currentCharacter between: $/ and: $9)
																or: [ (currentCharacter between: $A and: $Z)
																		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
														ifTrue: [ [ self recordMatch: #(31).
															self step.
															currentCharacter == $-
																or: [ (currentCharacter between: $/ and: $9)
																		or: [ (currentCharacter between: $A and: $Z)
																				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
																whileTrue ].
													^ self reportLastMatch ] ].
									(('-/' includes: currentCharacter)
										or: [ (currentCharacter between: $A and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
										ifTrue: [ [ self recordMatch: #(31).
											self step.
											currentCharacter == $-
												or: [ (currentCharacter between: $/ and: $9)
														or: [ (currentCharacter between: $A and: $Z)
																or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
												whileTrue ].
									^ self reportLastMatch ].
							(currentCharacter == $-
								or: [ (currentCharacter between: $/ and: $9)
										or: [ (currentCharacter between: $A and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
								ifTrue: [ [ self recordMatch: #(31).
									self step.
									currentCharacter == $-
										or: [ (currentCharacter between: $/ and: $9)
												or: [ (currentCharacter between: $A and: $Z)
														or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
										whileTrue ].
							^ self reportLastMatch ] ].
			(('-/' includes: currentCharacter)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
				ifTrue: [ [ self recordMatch: #(31).
					self step.
					currentCharacter == $-
						or: [ (currentCharacter between: $/ and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	((currentCharacter between: $/ and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan24 [
	self step.
	currentCharacter isDigit
		ifTrue: [ self step.
			currentCharacter isDigit
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ self step.
							currentCharacter isDigit
								ifTrue: [ self step.
									currentCharacter isDigit
										ifTrue: [ self recordMatch: #(28).
											self step.
											currentCharacter == $.
												ifTrue: [ self step.
													currentCharacter isDigit
														ifTrue: [ [ self recordMatch: #(28).
															self step.
															currentCharacter == $Z
																ifTrue: [ ^ self recordAndReportMatch: #(27) ].
															currentCharacter isDigit ] whileTrue.
															('+-' includes: currentCharacter) ifTrue: [ ^ self scan25 ] ].
													^ self reportLastMatch ].
											currentCharacter == $Z ifTrue: [ ^ self recordAndReportMatch: #(27) ].
											('+-' includes: currentCharacter) ifTrue: [ ^ self scan25 ] ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan25 [
	self step.
	currentCharacter isDigit
		ifTrue: [ self step.
			currentCharacter isDigit
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ self step.
							currentCharacter isDigit
								ifTrue: [ self step.
									currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(27) ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan26 [
	self step.
	currentCharacter isDigit
		ifTrue: [ self step.
			currentCharacter isDigit
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ self step.
							currentCharacter isDigit
								ifTrue: [ self step.
									currentCharacter isDigit
										ifTrue: [ self recordMatch: #(30).
											self step.
											currentCharacter == $.
												ifTrue: [ self step.
													currentCharacter isDigit
														ifTrue: [ [ self recordMatch: #(30).
															self step.
															currentCharacter isDigit ] whileTrue ] ] ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan27 [
	self recordMatch: #(31).
	self step.
	(currentCharacter between: $0 and: $1)
		ifTrue: [ [ self recordMatch: #(26 31).
			self step.
			currentCharacter == $_ ifTrue: [ ^ self scan27 ].
			currentCharacter between: $0 and: $1 ] whileTrue.
			(currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ])
				ifTrue: [ [ self recordMatch: #(31).
					self step.
					currentCharacter == $-
						or: [ (currentCharacter between: $/ and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $/ and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan28 [
	self recordMatch: #(31).
	self step.
	(currentCharacter between: $0 and: $7)
		ifTrue: [ [ self recordMatch: #(25 31).
			self step.
			currentCharacter == $_ ifTrue: [ ^ self scan28 ].
			currentCharacter between: $0 and: $7 ] whileTrue.
			(currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ])
				ifTrue: [ [ self recordMatch: #(31).
					self step.
					currentCharacter == $-
						or: [ (currentCharacter between: $/ and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $/ and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan29 [
	self recordMatch: #(31).
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ [ self recordMatch: #(24 31).
			self step.
			currentCharacter == $_ ifTrue: [ ^ self scan29 ].
			currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ] ] whileTrue.
			(('-/' includes: currentCharacter)
				or: [ (currentCharacter between: $G and: $Z)
						or: [ currentCharacter between: $g and: $z ] ])
				ifTrue: [ [ self recordMatch: #(31).
					self step.
					currentCharacter == $-
						or: [ (currentCharacter between: $/ and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $G and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $g and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan3 [
	[ self step.
	currentCharacter == $" ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $\ ifTrue: [ ^ self scan4 ].
	true ] whileTrue
]

{ #category : #generated }
GodotTscnScanner >> scan4 [
	self step.
	currentCharacter == $U
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ ^ self scan5 ] ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $u ifTrue: [ ^ self scan5 ].
	('"/\bfnrt' includes: currentCharacter) ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan5 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ ^ self scan3 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan6 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ (self scanForString: '""') ifTrue: [ ^ self recordAndReportMatch: #(17) ].
			^ self reportLastMatch ].
	currentCharacter == $\
		ifTrue: [ self step.
			currentCharacter == Character cr
				ifTrue: [ self step.
					currentCharacter == Character lf ifTrue: [ ^ self scan6 ].
					^ self reportLastMatch ].
			currentCharacter == $U
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ self step.
											(currentCharacter isDigit
												or: [ (currentCharacter between: $A and: $F)
														or: [ currentCharacter between: $a and: $f ] ])
												ifTrue: [ ^ self scan7 ] ] ] ].
					^ self reportLastMatch ].
			currentCharacter == $u ifTrue: [ ^ self scan7 ].
			(currentCharacter == Character lf
				or: [ '"/\bfnrt' includes: currentCharacter ]) ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GodotTscnScanner >> scan7 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ ^ self scan6 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan8 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ (self scanForString: '''''') ifTrue: [ ^ self recordAndReportMatch: #(19) ].
			^ self scan8 ].
	currentCharacter <= $[ or: [ currentCharacter >= $] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scan9 [
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter == $_ ifTrue: [ ^ self scan9 ].
			currentCharacter isDigit ] whileTrue.
			('Ee' includes: currentCharacter) ifTrue: [ ^ self scan10 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForToken [
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self scan1 ].
	currentCharacter == Character cr ifTrue: [ ^ self scan2 ].
	currentCharacter == $" ifTrue: [ ^ self scanForTokenX7 ].
	currentCharacter == $# ifTrue: [ ^ self scanForTokenX9 ].
	^ self scanForTokenX11
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX1 [
	self recordMatch: #(23 31).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $b ifTrue: [ ^ self scan27 ].
	currentCharacter == $o ifTrue: [ ^ self scan28 ].
	currentCharacter == $x ifTrue: [ ^ self scan29 ].
	currentCharacter isDigit ifTrue: [ ^ self scanForTokenX1X1 ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	((currentCharacter between: $- and: $/)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ self scanForTokenX1X2 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX10 [
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	currentCharacter == $i ifTrue: [ ^ self scan19 ].
	currentCharacter == $n ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter isDigit ifTrue: [ ^ self scanForTokenX3 ].
	(currentCharacter == Character tab or: [ currentCharacter == Character space ])
		ifTrue: [ ^ self scanForTokenX8 ].
	(currentCharacter == $/
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ self scanForTokenX5 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX11 [
	currentCharacter == $& ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $' ifTrue: [ ^ self scanForTokenX6 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $+ ifTrue: [ ^ self scanForTokenX4 ].
	currentCharacter == $, ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $- ifTrue: [ ^ self scanForTokenX2 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $0 ifTrue: [ ^ self scanForTokenX1 ].
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	^ self scanForTokenX10
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX1X1 [
	self recordMatch: #(31).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan26 ].
	currentCharacter isDigit
		ifTrue: [ self recordMatch: #(31).
			self step.
			currentCharacter isDigit
				ifTrue: [ self recordMatch: #(31).
					self step.
					currentCharacter == $- ifTrue: [ ^ self scan21 ].
					((currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
						ifTrue: [ [ self recordMatch: #(31).
							self step.
							currentCharacter == $-
								or: [ (currentCharacter between: $/ and: $9)
										or: [ (currentCharacter between: $A and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
								whileTrue ].
					^ self reportLastMatch ] ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX1X2 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter == $-
		or: [ (currentCharacter between: $/ and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX2 [
	self recordMatch: #(31).
	self step.
	currentCharacter == $0 ifTrue: [ ^ self scanForTokenX2X1 ].
	currentCharacter == $i ifTrue: [ ^ self scan19 ].
	currentCharacter == $n ifTrue: [ ^ self scan20 ].
	currentCharacter isDigit ifTrue: [ ^ self scan17 ].
	(('-/' includes: currentCharacter)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX2X1 [
	self recordMatch: #(23 31).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	((currentCharacter between: $- and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX3 [
	self recordMatch: #(23 31).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan9 ].
	currentCharacter == $_ ifTrue: [ ^ self scan18 ].
	currentCharacter isDigit
		ifTrue: [ self recordMatch: #(23 31).
			self step.
			currentCharacter == $. ifTrue: [ ^ self scan9 ].
			currentCharacter == $: ifTrue: [ ^ self scan26 ].
			currentCharacter == $_ ifTrue: [ ^ self scan18 ].
			currentCharacter isDigit
				ifTrue: [ self recordMatch: #(23 31).
					self step.
					currentCharacter == $. ifTrue: [ ^ self scan9 ].
					currentCharacter == $_ ifTrue: [ ^ self scan18 ].
					currentCharacter isDigit
						ifTrue: [ self recordMatch: #(23 31).
							self step.
							currentCharacter == $- ifTrue: [ ^ self scan21 ].
							currentCharacter == $. ifTrue: [ ^ self scan9 ].
							currentCharacter == $_ ifTrue: [ ^ self scan18 ].
							currentCharacter isDigit ifTrue: [ ^ self scan17 ].
							('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
							(currentCharacter == $/
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter between: $a and: $z ] ])
								ifTrue: [ [ self recordMatch: #(31).
									self step.
									currentCharacter == $-
										or: [ (currentCharacter between: $/ and: $9)
												or: [ (currentCharacter between: $A and: $Z)
														or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
										whileTrue ].
							^ self reportLastMatch ] ] ].
	('Ee' includes: currentCharacter) ifTrue: [ ^ self scan14 ].
	((currentCharacter between: $- and: $/)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(31).
			self step.
			currentCharacter == $-
				or: [ (currentCharacter between: $/ and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX4 [
	self step.
	currentCharacter == $0
		ifTrue: [ self recordMatch: #(23).
			self step.
			currentCharacter == $. ifTrue: [ ^ self scan9 ].
			('Ee' includes: currentCharacter) ifTrue: [ ^ self scan10 ].
			^ self reportLastMatch ].
	currentCharacter == $i
		ifTrue: [ (self scanForString: 'nf') ifTrue: [ ^ self recordAndReportMatch: #(21) ].
			^ self reportLastMatch ].
	currentCharacter == $n
		ifTrue: [ (self scanForString: 'an') ifTrue: [ ^ self recordAndReportMatch: #(22) ].
			^ self reportLastMatch ].
	currentCharacter isDigit ifTrue: [ ^ self scan13 ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX5 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter == $-
		or: [ (currentCharacter between: $/ and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX6 [
	self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(18).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan8 ].
			^ self reportLastMatch ].
	(currentCharacter <= Character tab or: [ currentCharacter >= Character pageUp ])
		ifTrue: [ [ self step.
			currentCharacter == $' ifTrue: [ ^ self recordAndReportMatch: #(18) ].
			currentCharacter <= Character tab
				or: [ currentCharacter >= Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX7 [
	self step.
	currentCharacter == $"
		ifTrue: [ self recordMatch: #(16).
			self step.
			currentCharacter == $" ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	currentCharacter == $\ ifTrue: [ ^ self scan4 ].
	^ self scan3
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX8 [
	[ self recordMatch: #(12).
	self step.
	currentCharacter == Character tab or: [ currentCharacter == Character space ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> scanForTokenX9 [
	[ self recordMatch: #(14).
	self step.
	currentCharacter ~~ Character lf ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GodotTscnScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil #whitespace)
]
