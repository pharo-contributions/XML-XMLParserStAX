"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestXMLParserStAXTests,
	#superclass : #PackageManifest,
	#category : #'XML-ParserStAX-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestXMLParserStAXTests class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'XML-ParserStAX-Tests')) #'2019-11-06T12:13:35.430731+01:00') )
]
