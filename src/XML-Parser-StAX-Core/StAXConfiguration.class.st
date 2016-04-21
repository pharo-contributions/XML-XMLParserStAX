"
StAX-specific configuration options.
"
Class {
	#name : #StAXConfiguration,
	#superclass : #XMLConfiguration,
	#instVars : [
		'skipsCommentEvents',
		'skipsPIEvents',
		'usesSeparateCDataEvents',
		'domConfiguration'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #accessing }
StAXConfiguration >> decodesCharacters: aBoolean [
	super decodesCharacters: aBoolean.
	self updateDOMConfiguration.
]

{ #category : #accessing }
StAXConfiguration >> defaultParserHandlerClass [
	^ StAXParser
]

{ #category : #accessing }
StAXConfiguration >> domConfiguration [
	"the dom configuration is created once and updated to ensure nodes
	share the same config"
	^ domConfiguration
		ifNil: [
			domConfiguration := XMLDOMConfiguration new.
			self updateDOMConfiguration.
			domConfiguration]
]

{ #category : #accessing }
StAXConfiguration >> entityConfiguration: anEntityConfiguration [
	super entityConfiguration: anEntityConfiguration.
	self updateDOMConfiguration.
]

{ #category : #initialization }
StAXConfiguration >> initialize [
	super initialize.

	skipsCommentEvents := true.
	skipsPIEvents := false.
	usesSeparateCDataEvents := false.
]

{ #category : #accessing }
StAXConfiguration >> isValidating: aBoolean [
	super isValidating: aBoolean.
	self updateDOMConfiguration.
]

{ #category : #accessing }
StAXConfiguration >> nodeFactory [
	^ self domConfiguration nodeFactory
]

{ #category : #accessing }
StAXConfiguration >> nodeFactory: aNodeFactory [
	self domConfiguration nodeFactory: aNodeFactory
]

{ #category : #accessing }
StAXConfiguration >> parserLimits: aParserLimits [
	super parserLimits: aParserLimits.
	self updateDOMConfiguration.
]

{ #category : #copying }
StAXConfiguration >> postCopy [
	super postCopy.

	domConfiguration
		ifNotNil: [domConfiguration := domConfiguration copy].
]

{ #category : #accessing }
StAXConfiguration >> requiresDocumentConstraints: aBoolean [
	super requiresDocumentConstraints: aBoolean.
	self updateDOMConfiguration.
]

{ #category : #accessing }
StAXConfiguration >> skipsCommentEvents [
	^ skipsCommentEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsCommentEvents: aBoolean [
	skipsCommentEvents := aBoolean.
	self updateDOMConfiguration.
]

{ #category : #accessing }
StAXConfiguration >> skipsPIEvents [
	^ skipsPIEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsPIEvents: aBoolean [
	skipsPIEvents := aBoolean
]

{ #category : #private }
StAXConfiguration >> updateDOMConfiguration [
	domConfiguration
		ifNotNil: [
			domConfiguration
				isValidating: self isValidating;
				usesNamespaces: self usesNamespaces;
				requiresDocumentConstraints: self requiresDocumentConstraints;
				decodesCharacters: self decodesCharacters;
				parserLimits: self parserLimits;
				entityConfiguration: self entityConfiguration;
				preservesCDataNodes: self usesSeparateCDataEvents;
				preservesCommentNodes: self skipsCommentEvents not]
]

{ #category : #accessing }
StAXConfiguration >> usesNamespaces: aBoolean [
	super usesNamespaces: aBoolean.
	self updateDOMConfiguration.
]

{ #category : #accessing }
StAXConfiguration >> usesSeparateCDataEvents [
	^ usesSeparateCDataEvents
]

{ #category : #accessing }
StAXConfiguration >> usesSeparateCDataEvents: aBoolean [
	usesSeparateCDataEvents := aBoolean.
	self updateDOMConfiguration.
]
