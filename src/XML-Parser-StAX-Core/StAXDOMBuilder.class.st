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
		'nextNode'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXDOMBuilder class >> on: aStreamOrCollection [
	^ self new on: aStreamOrCollection
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildCDataEvent: anEvent [
	self topNodeAdd: (self nodeFactory newCData: anEvent string)
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildCommentEvent: anEvent [
	self topNodeAdd: (self nodeFactory newComment: anEvent string)
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
				or: [self hasBuiltNextNode]]
				whileFalse: [self buildNextEvent].
			result := self nextNode.
			self nextNode: nil].
	^ result.
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildPIEvent: anEvent [
	self topNodeAdd:
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
		nextNode: document;
		pushNode: document.
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildStartTagEvent: anEvent [
	| element |

	element :=
		(self nodeFactory
			classForElement: anEvent name
			namespaceURI: anEvent namespaceURI
			localName: anEvent localName
			attributes: anEvent attributes) new.
	element
		setConfiguration: self configuration
		name: anEvent name
		localName: anEvent localName
		attributes: anEvent attributes.
	element setNamespaceScope: anEvent namespaceScope.

	self pushElement: element.
]

{ #category : #'building - events' }
StAXDOMBuilder >> buildStringEvent: anEvent [
	self topNode
		ifNil: [self nextNode: (self nodeFactory newStringNode: anEvent string)]
		ifNotNil: [:topNode | topNode addString: anEvent string]
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

{ #category : #testing }
StAXDOMBuilder >> hasBuiltNextNode [
	^ self nextNode notNil
		and: [self nodeStack isEmpty]
]

{ #category : #accessing }
StAXDOMBuilder >> nextNode [
	^ nextNode
]

{ #category : #private }
StAXDOMBuilder >> nextNode: aNode [
	nextNode := aNode
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
StAXDOMBuilder >> pushElement: anElement [
	self topNodeAdd: anElement.
	^ self pushNode: anElement.
]

{ #category : #private }
StAXDOMBuilder >> pushNode: aNode [
	^ self nodeStack addLast: aNode
]

{ #category : #private }
StAXDOMBuilder >> topNode [
	^ self nodeStack xmlLastOrNil
]

{ #category : #private }
StAXDOMBuilder >> topNodeAdd: aNode [
	self topNode
		ifNil: [self nextNode: aNode]
		ifNotNil: [:topNode | topNode addNode: aNode].
	^ aNode.
]
