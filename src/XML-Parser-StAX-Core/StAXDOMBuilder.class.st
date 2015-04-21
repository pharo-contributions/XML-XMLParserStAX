"
This class builds a DOM tree from StAX events.
"
Class {
	#name : #StAXDOMBuilder,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'eventStream',
		'nodeStack',
		'currentNode'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXDOMBuilder class >> on: aStreamOrCollection [
	^ self new on: aStreamOrCollection
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildCDataEvent: anEvent [
	self nodeStackTopAddNode: (self nodeFactory newCData: anEvent string)
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildCommentEvent: anEvent [
	self nodeStackTopAddNode: (self nodeFactory newComment: anEvent string)
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildEndDocumentEvent: anEvent [
	self popNode
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildEndTagEvent: anEvent [
	self popNode
]

{ #category : #'building - nodes' }
StAXDOMBuilder >> buildNextElement [
	[eventStream atEnd
		or: [eventStream peek isStartTag]]
		whileFalse: [eventStream next].
	^ self buildNextNode.
]

{ #category : #'building - nodes' }
StAXDOMBuilder >> buildNextElementNamed: aName [
	[eventStream atEnd
		or: [eventStream peek isStartTagNamed: aName]]
		whileFalse: [eventStream next].
	^ self buildNextNode.
]

{ #category : #'building - nodes' }
StAXDOMBuilder >> buildNextElementNamed: aName namespaceURI: aURI [
	[eventStream atEnd
		or: [(eventStream peek isStartTagNamed: aName)
			and: [eventStream peek namespaceURI = aURI]]]
		whileFalse: [eventStream next].
	^ self buildNextNode.
]

{ #category : #private }
StAXDOMBuilder >> buildNextEvent [
	eventStream next buildWith: self
]

{ #category : #'building - nodes' }
StAXDOMBuilder >> buildNextNode [
	| result |

	eventStream atEnd
		ifFalse: [
			[eventStream atEnd
				or: [self hasBuiltCurrentNode]]
				whileFalse: [self buildNextEvent].
			result := self currentNode.
			self currentNode: nil].
	^ result.
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildPIEvent: anEvent [
	self nodeStackTopAddNode:
		(self nodeFactory newPI
			target: anEvent target;
			data: anEvent data)
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildStartDocumentEvent: anEvent [
	| document |

	(document := self nodeFactory newDocument)
		configuration: self configuration.
	self
		currentNode: document;
		pushNode: document.
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildStartTagEvent: anEvent [
	| element |

	element :=
		(self nodeFactory
			classForElement: anEvent name
			prefix: (anEvent name prefixBeforeLocalName: anEvent localName)
			uri: anEvent namespaceURI
			localName: anEvent localName) new.
	element
		configuration: self configuration;
		setQualifiedName: anEvent name
		localName: anEvent localName
		attributes: anEvent attributes;
		setNamespaceScope: anEvent namespaceScope.

	self
		nodeStackTopAddNode: element;
		pushNode: element.
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildTextEvent: anEvent [
	self nodeStackTopAddNode: (self nodeFactory newString: anEvent string)
]

{ #category : #accessing }
StAXDOMBuilder >> configuration [
	^ configuration ifNil: [configuration := self configurationClass new]
]

{ #category : #accessing }
StAXDOMBuilder >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #private }
StAXDOMBuilder >> configurationClass [
	^ XMLDOMConfiguration
]

{ #category : #accessing }
StAXDOMBuilder >> currentNode [
	^ currentNode
]

{ #category : #private }
StAXDOMBuilder >> currentNode: aNode [
	currentNode := aNode
]

{ #category : #testing }
StAXDOMBuilder >> hasBuiltCurrentNode [
	^ self currentNode notNil
		and: [self nodeStack isEmpty]
]

{ #category : #private }
StAXDOMBuilder >> newNodeList [
	^ self nodeFactory nodeListClass new
]

{ #category : #accessing }
StAXDOMBuilder >> nodeFactory [
	^ self configuration nodeFactory
]

{ #category : #accessing }
StAXDOMBuilder >> nodeFactory: aNodeFactory [
	self configuration nodeFactory: aNodeFactory
]

{ #category : #private }
StAXDOMBuilder >> nodeStack [
	^ nodeStack
]

{ #category : #private }
StAXDOMBuilder >> nodeStackTopAddNode: aNode [
	self nodeStack lastOrNil
		ifNil: [self currentNode: aNode]
		ifNotNil: [:topNode | topNode addNode: aNode]
]

{ #category : #initialization }
StAXDOMBuilder >> on: aStreamOrCollection [
	eventStream :=
		aStreamOrCollection isStream
			ifTrue: [aStreamOrCollection]
			ifFalse: [aStreamOrCollection readStream].
	nodeStack := OrderedCollection new: 10.
]

{ #category : #private }
StAXDOMBuilder >> popNode [
	self nodeStack isEmpty
		ifTrue: [^ nil]
		ifFalse: [^ self nodeStack removeLast]
]

{ #category : #private }
StAXDOMBuilder >> pushNode: aNode [
	^ self nodeStack addLast: aNode
]
