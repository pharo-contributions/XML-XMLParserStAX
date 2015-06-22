"
This is a pull parser for XMLParser that provides a streaming interface for ""pulling"" XML events and also supports pull-style DOM parsing for dynamically converting events into DOM nodes.

Example:
	| parser item |
	parser := StAXParser on:
		'<list>
			<item>one</item>
			<item>two</item>
		</list>'.

	""get the first item as an XMLElement""
	item := parser nextElementNamed: 'item'.

This is a fork of XMLPullParser and is MIT licensed.
"
Class {
	#name : #StAXParser,
	#superclass : #SAXHandler,
	#instVars : [
		'parser',
		'current',
		'peek',
		'eventQueue',
		'lastEventAdded',
		'domBuilder'
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

{ #category : #testing }
StAXParser >> atEnd [
	^ current isEndDocument
]

{ #category : #'handling - content' }
StAXParser >> characters: aString [
	self addEvent:
		((self isInCDataSection
			and: [self usesSeparateCDataEvents])
			ifTrue: [StAXCDataEvent string: aString]
			ifFalse: [StAXTextEvent string: aString])
]

{ #category : #enumerating }
StAXParser >> collect: aBlock [
	| list |

	list := XMLOrderedList new.
	self do: [:each | list addLast: (aBlock value: each)].
	^ list.
]

{ #category : #'handling - lexical' }
StAXParser >> comment: aCommentString [
	(self isInContent
		and: [self skipsCommentEvents not])
		ifTrue: [
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

{ #category : #configuring }
StAXParser >> domBuilder [
	^ domBuilder ifNil: [
		domBuilder :=
			(self domBuilderClass on: self)
				configuration: self configuration domConfiguration]
]

{ #category : #private }
StAXParser >> domBuilderClass [
	^ StAXDOMBuilder
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

{ #category : #private }
StAXParser >> eventQueue [
	^ eventQueue
]

{ #category : #testing }
StAXParser >> isStream [
	^ true
]

{ #category : #private }
StAXParser >> lastEventAdded [
	^ lastEventAdded
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
	| eventList i |

	eventList := self newEventList.
	i := 1.
	[i > anInteger
		or: [self atEnd]]
		whileFalse: [
			eventList addLast: self next.
			i := i + 1].
	^ eventList.
]

{ #category : #'accessing - nodes' }
StAXParser >> nextElement [
	^ self domBuilder buildNextElement
]

{ #category : #'accessing - nodes' }
StAXParser >> nextElementNamed: aName [
	^ self domBuilder buildNextElementNamed: aName
]

{ #category : #'accessing - nodes' }
StAXParser >> nextElementNamed: aName namespaceURI: aURI [
	^ self domBuilder
		buildNextElementNamed: aName
		namespaceURI: aURI
]

{ #category : #'accessing - nodes' }
StAXParser >> nextNode [
	^ self domBuilder buildNextNode
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

{ #category : #configuring }
StAXParser >> nodeFactory [
	^ self configuration nodeFactory
]

{ #category : #configuring }
StAXParser >> nodeFactory: aNodeFactory [
	self configuration nodeFactory: aNodeFactory
]

{ #category : #initialization }
StAXParser >> on: aStringOrStream [
	super on: aStringOrStream.

	"on: allows reuse so all vars must be set"
	parser := self parser.
	current := StAXInitialEvent new.
	peek := nil.
	eventQueue := OrderedCollection new: 5.
	lastEventAdded := nil.
	domBuilder := nil.
]

{ #category : #parsing }
StAXParser >> parseDocument [
	"returns all events"
	^ self upToEnd
]

{ #category : #parsing }
StAXParser >> parseDocumentUntil: aBlock [
	"returns events until aBlock evaluates true"
	^ self nextUntil: aBlock
]

{ #category : #parsing }
StAXParser >> parseDocumentWhile: aBlock [
	"returns events while aBlock evaluates true"
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
	(self isInContent
		and: [self skipsPIEvents not])
		ifTrue: [
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
	^ self nextWhile: [true]
]

{ #category : #configuring }
StAXParser >> usesSeparateCDataEvents [
	^ self configuration usesSeparateCDataEvents
]

{ #category : #configuring }
StAXParser >> usesSeparateCDataEvents: aBoolean [
	self configuration usesSeparateCDataEvents: aBoolean
]
