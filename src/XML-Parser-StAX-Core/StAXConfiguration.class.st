"
StAX-specific configuration options.
"
Class {
	#name : #StAXConfiguration,
	#superclass : #XMLConfiguration,
	#instVars : [
		'skipsCDataEvents',
		'skipsCommentEvents',
		'skipsPIEvents'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #converting }
StAXConfiguration >> asDOMConfiguration [
	^ XMLDOMConfiguration new
		isValidating: self isValidating;
		usesNamespaces: self usesNamespaces;
		requiresDocumentConstraints: self requiresDocumentConstraints;
		parserLimits: self parserLimits;
		entityConfiguration: self entityConfiguration
]

{ #category : #accessing }
StAXConfiguration >> defaultParserHandlerClass [
	^ StAXParser
]

{ #category : #accessing }
StAXConfiguration >> initialize [
	super initialize.

	skipsCDataEvents := false.
	skipsCommentEvents := false.
	skipsPIEvents := false.
]

{ #category : #accessing }
StAXConfiguration >> skipsCDataEvents [
	^ skipsCDataEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsCDataEvents: aBoolean [
	skipsCDataEvents := aBoolean
]

{ #category : #accessing }
StAXConfiguration >> skipsCommentEvents [
	^ skipsCommentEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsCommentEvents: aBoolean [
	skipsCommentEvents := aBoolean
]

{ #category : #accessing }
StAXConfiguration >> skipsPIEvents [
	^ skipsPIEvents
]

{ #category : #accessing }
StAXConfiguration >> skipsPIEvents: aBoolean [
	skipsPIEvents := aBoolean
]
