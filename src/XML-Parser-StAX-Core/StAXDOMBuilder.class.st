"
This class builds a DOM tree from StAX events.
"
Class {
	#name : #StAXDOMBuilder,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'nodeStack',
		'currentRoot',
		'eventStream'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXDOMBuilder class >> on: aStreamOrCollection [
	^ self new on: aStreamOrCollection
]

{ #category : #building }
StAXDOMBuilder >> build [
	[eventStream atEnd or: [self isBuilt]]
		whileFalse: [eventStream next buildWith: self].
	^ self currentRoot.
]

{ #category : #'building - events' }
StAXDOMBuilder >> cdataEvent: anEvent [
	self topNodeAdd: (self nodeFactory newCData: anEvent string)
]

{ #category : #'building - events' }
StAXDOMBuilder >> commentEvent: anEvent [
	self topNodeAdd: (self nodeFactory newComment: anEvent string)
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
StAXDOMBuilder >> currentRoot [
	^ currentRoot
]

{ #category : #private }
StAXDOMBuilder >> currentRoot: aNode [
	currentRoot := aNode
]

{ #category : #'building - events' }
StAXDOMBuilder >> endDocumentEvent: anEvent [
	self popNode
]

{ #category : #'building - events' }
StAXDOMBuilder >> endTagEvent: anEvent [
	self popNode
]

{ #category : #testing }
StAXDOMBuilder >> isBuilt [
	^ self currentRoot notNil
		and: [self nodeStack isEmpty]
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
	nodeStack := OrderedCollection new: 10.
	eventStream :=
		aStreamOrCollection isStream
			ifTrue: [aStreamOrCollection]
			ifFalse: [aStreamOrCollection readStream].
]

{ #category : #'building - events' }
StAXDOMBuilder >> piEvent: anEvent [
	self topNodeAdd:
		(self nodeFactory newPI
			target: anEvent target;
			data: anEvent data)
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

{ #category : #'building - events' }
StAXDOMBuilder >> startDocumentEvent: anEvent [
	| document |

	(document := self nodeFactory newDocument)
		configuration: self configuration.
	self
		currentRoot: document;
		pushNode: document.
]

{ #category : #'building - events' }
StAXDOMBuilder >> startTagEvent: anEvent [
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
		topNodeAdd: element;
		pushNode: element.
]

{ #category : #'building - events' }
StAXDOMBuilder >> textEvent: anEvent [
	self topNodeAdd: (self nodeFactory newString: anEvent string)
]

{ #category : #private }
StAXDOMBuilder >> topNode [
	^ self nodeStack lastOrNil
]

{ #category : #private }
StAXDOMBuilder >> topNodeAdd: aNode [
	self topNode
		ifNil: [self currentRoot: aNode]
		ifNotNil: [:topNode | topNode addNode: aNode]
]
