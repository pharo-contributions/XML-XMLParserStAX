"
This is a StAX-style pull parser for XMLParser that provides a stream-like interface for ""pulling"" XML events and optionally converting them to DOM. It is a fork of XMLPullParser and is MIT licensed.

Examples:
	""get first book element as an XMLElement object:""
	element := 
		(parser := StAXParser on: xml)
			skipUntil: [parser peek isStartTag: 'book'];
			nextDOM.
"
Class {
	#name : #StAXParser,
	#superclass : #SAXHandler,
	#instVars : [
		'parser',
		'current',
		'peek',
		'eventQueue',
		'lastEventAdded'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #private }
StAXParser >> addEvent: anEvent [
	peek
		ifNil: [
			eventQueue isEmpty
				ifTrue: [peek := anEvent]
				ifFalse: [peek := eventQueue removeFirst]]
		ifNotNil: [eventQueue addLast: anEvent].
	lastEventAdded := anEvent.
]

{ #category : #converting }
StAXParser >> asDOMBuilder [
	| builder |

	builder := StAXDOMBuilder on: self.
	builder configuration: self configuration asDOMConfiguration.
	^ builder.
]

{ #category : #testing }
StAXParser >> atEnd [
	^ current isEndDocument
]

{ #category : #'handling - content' }
StAXParser >> characters: aString [
	self addEvent:
		((self isInCDataSection
			and: [self skipsCDataEvents not])
			ifTrue: [StAXCDataEvent string: aString]
			ifFalse: [StAXTextEvent string: aString])
]

{ #category : #enumerating }
StAXParser >> collect: aBlock [
	| list |

	list := XMLOrderedList new.
	self do: [:each | list addLast: (aBlock value: each)]
]

{ #category : #'handling - lexical' }
StAXParser >> comment: aCommentString [
	(self isInInternalSubset
		or: [self skipsCommentEvents])
		ifFalse: [
			self addEvent:
				(StAXCommentEvent string: aCommentString)]
]

{ #category : #private }
StAXParser >> configurationClass [
	^ StAXConfiguration
]

{ #category : #accessing }
StAXParser >> current [
	"returns what was last returned by next"
	^ current
]

{ #category : #private }
StAXParser >> currentScope: aNamespaceScope [
	lastEventAdded setNamespaceScope: aNamespaceScope
]

{ #category : #enumerating }
StAXParser >> detect: aBlock [
	^ self detect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
StAXParser >> detect: aBlock ifNone: anExceptionBlock [
	self do: [:each |
		(aBlock value: each)
			ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
StAXParser >> do: aBlock [
	[self atEnd] whileFalse: [aBlock value: self next]
]

{ #category : #'handling - content' }
StAXParser >> endDocument [
	self addEvent: StAXEndDocumentEvent new
]

{ #category : #'handling - content' }
StAXParser >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	self addEvent:
		(StAXEndTagEvent new
			setName: aQualifiedName
			localName: aLocalName
			namespaceURI: aURI)
]

{ #category : #testing }
StAXParser >> isStream [
	^ true
]

{ #category : #private }
StAXParser >> newEventList [
	^ StAXEventList configuration: self configuration
]

{ #category : #accessing }
StAXParser >> next [
	current := self peek.
	peek := nil.
	^ current.
]

{ #category : #accessing }
StAXParser >> next: anInteger [ 
	| eventList |

	eventList := self newEventList.
	1 to: anInteger do: [:each |
		self atEnd
			ifTrue: [^ eventList].
		eventList addLast: self next].
	^ eventList.
]

{ #category : #accessing }
StAXParser >> nextDOM [
	"returns the next event(s) as a DOM tree"
	^ self asDOMBuilder build
]

{ #category : #accessing }
StAXParser >> nextUntil: aBlock [
	| eventList |

	eventList := self newEventList.
	[self atEnd
		or: [aBlock value]]
		whileFalse: [eventList addLast: self next].
	^ eventList.
]

{ #category : #accessing }
StAXParser >> nextWhile: aBlock [
	| eventList |

	eventList := self newEventList.
	[self atEnd not
		and: [aBlock value]]
		whileTrue: [eventList addLast: self next].
	^ eventList.
]

{ #category : #initialization }
StAXParser >> on: aStringOrStream documentURI: aURI [
	super
		on: aStringOrStream
		documentURI: aURI.

	parser := self parser.
	current := StAXInitialEvent new.
	eventQueue := OrderedCollection new: 5.
]

{ #category : #parsing }
StAXParser >> parseDocument [
	^ self upToEnd
]

{ #category : #parsing }
StAXParser >> parseDocumentUntil: aBlock [
	^ self nextUntil: aBlock
]

{ #category : #parsing }
StAXParser >> parseDocumentWhile: aBlock [
	^ self nextWhile: aBlock
]

{ #category : #accessing }
StAXParser >> peek [
	peek
		ifNotNil: [^ peek].
	eventQueue isEmpty
		ifTrue: [
			[parser atEnd]
				whileFalse: [
					parser parseToken.
					peek ifNotNil: [^ peek]].
			^ peek := StAXEndDocumentEvent new]
		ifFalse: [^ peek := eventQueue removeFirst].
]

{ #category : #'handling - content' }
StAXParser >> processingInstruction: aTargetString data: aDataString [
	(self isInInternalSubset
		or: [self skipsPIEvents])
		ifFalse: [
			self addEvent:
				(StAXPIEvent
					target: aTargetString
					data: aDataString)]
]

{ #category : #enumerating }
StAXParser >> select: aBlock [
	| eventList |

	eventList := self newEventList.
	self do: [:each |
		(aBlock value: each)
			ifTrue: [eventList addLast: each]].
	^ eventList.
]

{ #category : #positioning }
StAXParser >> skip: anInteger [
	1 to: anInteger do: [:i | self next]
]

{ #category : #positioning }
StAXParser >> skipUntil: aBlock [
	[self atEnd or: [aBlock value]]
		whileFalse: [self next]
]

{ #category : #positioning }
StAXParser >> skipWhile: aBlock [
	[self atEnd not and: [aBlock value]]
		whileTrue: [self next]
]

{ #category : #configuring }
StAXParser >> skipsCDataEvents [
	^ self configuration skipsCDataEvents
]

{ #category : #configuring }
StAXParser >> skipsCDataEvents: aBoolean [
	self configuration skipsCDataEvents: aBoolean
]

{ #category : #configuring }
StAXParser >> skipsCommentEvents [
	^ self configuration skipsCommentEvents
]

{ #category : #configuring }
StAXParser >> skipsCommentEvents: aBoolean [
	self configuration skipsCommentEvents: aBoolean
]

{ #category : #configuring }
StAXParser >> skipsPIEvents [
	^ self configuration skipsPIEvents
]

{ #category : #configuring }
StAXParser >> skipsPIEvents: aBoolean [
	self configuration skipsPIEvents: aBoolean
]

{ #category : #'handling - content' }
StAXParser >> startDocument [
	self addEvent: StAXStartDocumentEvent new
]

{ #category : #'handling - content' }
StAXParser >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: anAttributeCollection [
	self addEvent:
		(StAXStartTagEvent new
			setName: aQualifiedName
			localName: aLocalName
			namespaceURI: aURI
			attributes: anAttributeCollection)
]

{ #category : #accessing }
StAXParser >> upToEnd [
	^ self nextWhile: [self atEnd not]
]
