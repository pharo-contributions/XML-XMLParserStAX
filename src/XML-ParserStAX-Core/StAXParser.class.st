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
		'domBuilder',
		'currentScope'
	],
	#category : #'XML-ParserStAX-Core'
}

{ #category : #private }
StAXParser >> addEvent: anEvent [
	^ peek
		ifNil: [
			eventQueue size > 0
				ifTrue: [eventQueue addLast: anEvent]
				ifFalse: [peek := anEvent]]
		ifNotNil: [eventQueue addLast: anEvent]
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
			ifFalse: [StAXStringEvent string: aString])
]

{ #category : #enumerating }
StAXParser >> collect: aBlock [
	| list |

	list := XMLOrderedList new.
	self do: [:each | list addLast: (aBlock value: each)].
	^ list.
]

{ #category : #'handling - lexical' }
StAXParser >> comment: aString [
	(self isInContent
		and: [self skipsCommentEvents not])
		ifTrue: [
			self addEvent:
				(StAXCommentEvent string: aString)]
]

{ #category : #defaults }
StAXParser >> configurationClass [
	^ StAXConfiguration
]

{ #category : #accessing }
StAXParser >> current [
	"Returns what was last returned by #next"

	^ current
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

{ #category : #defaults }
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
			namespaceScope: currentScope)
]

{ #category : #defaults }
StAXParser >> eventListClass [
	^ StAXEventList
]

{ #category : #private }
StAXParser >> eventQueue [
	^ eventQueue
]

{ #category : #initialization }
StAXParser >> initializeParser: aParser [
	super initializeParser: aParser.

	parser := aParser.
]

{ #category : #testing }
StAXParser >> isStream [
	^ true
]

{ #category : #'instance creation' }
StAXParser >> newEventList [
	^ self eventListClass configuration: self configuration
]

{ #category : #accessing }
StAXParser >> next [
	"Returns the next event in the event stream or an end-of-document
	event if there isn't one."

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
	"Builds and returns a new XMLElement from the next element event(s), skipping
	events if needed to find the element start. Returns nil if there is no next
	element.

	Use #peek and #isStartTag before to prevent event skipping."

	^ self domBuilder buildNextElement
]

{ #category : #'accessing - nodes' }
StAXParser >> nextElementNamed: aName [
	"Builds and returns a new XMLElement from the event(s) of the next element
	with the specified name, skipping events if needed to find the element start.
	Returns nil if there is no next element.

	Use #peek and #isStartTagNamed: before to prevent event skipping."

	^ self domBuilder buildNextElementNamed: aName
]

{ #category : #'accessing - nodes' }
StAXParser >> nextElementNamed: aName namespaceURI: aURI [
	"Builds and returns a new XMLElement from the event(s) of the next element
	with the specified name and namespace URI, skipping events if needed to
	find the element start. Returns nil if there is no next element.
	
	Use #peek, #isStartTagNamed:, and #namespaceURI before to prevent event
	skipping."

	^ self domBuilder
		buildNextElementNamed: aName
		namespaceURI: aURI
]

{ #category : #'accessing - tags' }
StAXParser >> nextEndTag [
	[self atEnd
		or: [self peek isEndTag]]
		whileFalse: [self next].
	^ self next.
]

{ #category : #'accessing - tags' }
StAXParser >> nextEndTagNamed: aName [
	[self atEnd
		or: [self peek isEndTagNamed: aName]]
		whileFalse: [self next].
	^ self next.
]

{ #category : #'accessing - tags' }
StAXParser >> nextEndTagNamed: aName namespaceURI: aURI [
	[self atEnd
		or: [
			(self peek isEndTagNamed: aName)
				and: [self peek namespaceURI = aURI]]]
		whileFalse: [self next].
	^ self next.
]

{ #category : #'accessing - nodes' }
StAXParser >> nextNode [
	"Returns the next events as some kind of DOM subtree of XMLNodes. The node
	returned is the root of the tree. Returns nil if there aren't enough
	events to construct a node."

	^ self domBuilder buildNextNode
]

{ #category : #'accessing - tags' }
StAXParser >> nextStartTag [
	[self atEnd
		or: [self peek isStartTag]]
		whileFalse: [self next].
	^ self next.
]

{ #category : #'accessing - tags' }
StAXParser >> nextStartTagNamed: aName [
	[self atEnd
		or: [self peek isStartTagNamed: aName]]
		whileFalse: [self next].
	^ self next.
]

{ #category : #'accessing - tags' }
StAXParser >> nextStartTagNamed: aName namespaceURI: aURI [
	[self atEnd
		or: [
			(self peek isStartTagNamed: aName)
				and: [self peek namespaceURI = aURI]]]
		whileFalse: [self next].
	^ self next.
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

	"#on: allows reuse so all vars must be reset"
	parser := nil.
	current := StAXInitialEvent new.
	peek := nil.
	eventQueue := OrderedCollection new: 5.
	domBuilder := nil.
	currentScope := nil.
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
	"Peeks the next event in the event stream or returns an
	end-of-document event if there isn't one."

	peek
		ifNotNil: [^ peek].
	eventQueue size > 0 "optimization"
		ifTrue: [^ peek := eventQueue removeFirst].

	"this is here instead of in #on: to delay parser creation as long
	as possible for configuration, just before 'parser' is first referenced"
	hasParser
		ifFalse: [self parser].
	[parser atEnd]
		whileFalse: [
			parser parseToken.
			peek
				ifNotNil: [^ peek]].
	^ peek := StAXEndDocumentEvent new.
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
	"Should comment events be skipped?
	(Default)"
	self configuration skipsCommentEvents: aBoolean
]

{ #category : #configuring }
StAXParser >> skipsPIEvents [
	^ self configuration skipsPIEvents
]

{ #category : #configuring }
StAXParser >> skipsPIEvents: aBoolean [
	"Should PI events be skipped?
	(Not default)"
	self configuration skipsPIEvents: aBoolean
]

{ #category : #'handling - content' }
StAXParser >> startDocument [
	self addEvent: StAXStartDocumentEvent new
]

{ #category : #'handling - content' }
StAXParser >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: anAttributeDictionary [
	self addEvent:
		(StAXStartTagEvent new
			setName: aQualifiedName
			localName: aLocalName
			attributes: anAttributeDictionary
			namespaceScope: currentScope)
]

{ #category : #private }
StAXParser >> startScope: aNamespaceScope [
	currentScope := aNamespaceScope
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
	"Should <![CDATA[...]]> sections be preserved as separate events?
	(Not default)"
	self configuration usesSeparateCDataEvents: aBoolean
]
