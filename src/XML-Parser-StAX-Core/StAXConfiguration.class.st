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
StAXConfiguration >> defaultParserHandlerClass [
	^ StAXParser
]

{ #category : #accessing }
StAXConfiguration >> domConfiguration [
	^ domConfiguration
		ifNil: [
			domConfiguration := XMLDOMConfiguration new.
			self updateDOMConfiguration.
			domConfiguration]
]

{ #category : #initialization }
StAXConfiguration >> initialize [
	super initialize.

	usesSeparateCDataEvents := true.
	skipsCommentEvents := false.
	skipsPIEvents := false.
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
StAXConfiguration >> requiresDocumentConstraints: aBoolean [
	super requiresDocumentConstraints: aBoolean..
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
				parserLimits: self parserLimits;
				entityConfiguration: self entityConfiguration;
				preservesCDataNodes: self usesSeparateCDataEvents;
				preservesCommentNodes: self skipsCommentEvents not]
]

{ #category : #accessing }
StAXConfiguration >> usesNamespaces: aBoolean [
	super usesNamespaces: aBoolean..
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
