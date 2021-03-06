' Copyright (c) 2007-2016 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import BRL.Blitz
Import BRL.Stream

Import "src/*.h"

Import "src/xmlparse.c"
Import "src/xmlrole.c"
Import "src/xmltok.c"
Import "src/xmltok_impl.c"
Import "src/xmltok_ns.c"

Import "glue.cpp"

Extern

	Function bmx_expat_XML_ParserCreate:Byte Ptr(encoding:String)
	Function bmx_expat_XML_Parse:Int(handle:Byte Ptr, Text:String, isFinal:Int)
	Function bmx_expat_XML_SetStartElementHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetEndElementHandler(handle:Byte Ptr)
	Function bmx_expat_XML_GetParsingStatus(handle:Byte Ptr, parsing:Int Ptr, finalBuffer:Int Ptr)
	Function bmx_expat_XML_SetElementHandler(handle:Byte Ptr, hasStart:Int, hasEnd:Int)
	Function bmx_expat_XML_SetCharacterDataHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetProcessingInstructionHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetCommentHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetStartCdataSectionHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetEndCdataSectionHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetCdataSectionHandler(handle:Byte Ptr, hasStart:Int, hasEnd:Int)
	Function bmx_expat_XML_SetDefaultHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetDefaultHandlerExpand(handle:Byte Ptr)
	Function bmx_expat_XML_SetSkippedEntityHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetStartNamespaceDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetEndNamespaceDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetNamespaceDeclHandler(handle:Byte Ptr, hasStart:Int, hasEnd:Int)
	Function bmx_expat_XML_SetXmlDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetStartDoctypeDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetEndDoctypeDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetDoctypeDeclHandler(handle:Byte Ptr, hasStart:Int, hasEnd:Int)
	Function bmx_expat_XML_SetAttlistDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetEntityDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetNotationDeclHandler(handle:Byte Ptr)
	Function bmx_expat_XML_SetNotStandaloneHandler(handle:Byte Ptr)

	Function bmx_expat_XML_ErrorString:String(code:Int)
	Function bmx_expat_XML_ExpatVersion:String()
	Function bmx_expat_XML_ExpatVersionInfo(major:Int Ptr, minor:Int Ptr, micro:Int Ptr)
	Function bmx_expat_XML_SetBase:Int(handle:Byte Ptr, base:String)
	Function bmx_expat_XML_GetBase:String(handle:Byte Ptr)
	Function bmx_expat_XML_SetEncoding:Int(handle:Byte Ptr, encoding:String)

	' ++ direct calls to the library - no glue required ++
	Function XML_ParserFree(handle:Byte Ptr)
	Function XML_SetUserData(handle:Byte Ptr, data:Object)
	Function XML_StopParser:Int(handle:Byte Ptr, resumable:Int)
	Function XML_ResumeParser:Int(handle:Byte Ptr)
	
	Function XML_SetStartElementHandler(handle:Byte Ptr, cb(data:Byte Ptr, name:Byte Ptr, attr:Byte Ptr Ptr))
	Function XML_SetEndElementHandler(handle:Byte Ptr, cb(data:Byte Ptr, name:Byte Ptr))
	Function XML_SetElementHandler(handle:Byte Ptr, cb1(data:Byte Ptr, name:Byte Ptr, attr:Byte Ptr Ptr), ..
			cb2(data:Byte Ptr, name:Byte Ptr))
	Function XML_SetCharacterDataHandler(handle:Byte Ptr, cb(data:Byte Ptr, Text:Byte Ptr))
	Function XML_SetProcessingInstructionHandler(handle:Byte Ptr, cb(userdata:Byte Ptr, target:Byte Ptr, data:Byte Ptr))
	Function XML_SetCommentHandler(handle:Byte Ptr, cb(userData:Byte Ptr, data:Byte Ptr))
	Function XML_SetStartCdataSectionHandler(handle:Byte Ptr, cb(userData:Byte Ptr))
	Function XML_SetEndCdataSectionHandler(handle:Byte Ptr, cb(userData:Byte Ptr))
	Function XML_SetCdataSectionHandler(handle:Byte Ptr, cb1(userData:Byte Ptr), cb2(userData:Byte Ptr))
	Function XML_SetDefaultHandler(handle:Byte Ptr, cb(userData:Byte Ptr, data:Byte Ptr, length:Int))
	Function XML_SetDefaultHandlerExpand(handle:Byte Ptr, cb(userData:Byte Ptr, data:Byte Ptr, length:Int))
	Function XML_SetSkippedEntityHandler(handle:Byte Ptr, cb(userData:Byte Ptr, name:Byte Ptr, isParamEntity:Int))
	Function XML_SetStartNamespaceDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, prefix:Byte Ptr, uri:Byte Ptr))
	Function XML_SetEndNamespaceDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, prefix:Byte Ptr))
	Function XML_SetNamespaceDeclHandler(handle:Byte Ptr, cb1(userData:Byte Ptr, prefix:Byte Ptr, uri:Byte Ptr), ..
		cb2(userData:Byte Ptr, prefix:Byte Ptr))
	Function XML_SetXmlDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, version:Byte Ptr, encoding:Byte Ptr, standalone:Int))
	Function XML_SetStartDoctypeDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, name:Byte Ptr, sysid:Byte Ptr, pubid:Byte Ptr, ..
		hasInternalSubset:Int))
	Function XML_SetEndDoctypeDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr))
	Function XML_SetDoctypeDeclHandler(handle:Byte Ptr, cb1(userData:Byte Ptr, name:Byte Ptr, sysid:Byte Ptr, pubid:Byte Ptr, ..
		hasInternalSubset:Int), cb2(userData:Byte Ptr))
	Function XML_SetAttlistDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, elname:Byte Ptr, attname:Byte Ptr, attType:Byte Ptr, ..
			dflt:Byte Ptr, isRequired:Int))
	Function XML_SetEntityDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, _entityName:Byte Ptr, isParameterEntity:Int, value:Byte Ptr, ..
			base:Byte Ptr, systemId:Byte Ptr, publicId:Byte Ptr, notationName:Byte Ptr))
	Function XML_SetNotationDeclHandler(handle:Byte Ptr, cb(userData:Byte Ptr, notationName:Byte Ptr, base:Byte Ptr, systemId:Byte Ptr, ..
			publicId:Byte Ptr))
	Function XML_SetNotStandaloneHandler(handle:Byte Ptr, cb:Int(userData:Byte Ptr))
	
	Function XML_GetErrorCode:Int(handle:Byte Ptr)
	Function XML_GetCurrentLineNumber:Int(handle:Byte Ptr)
	Function XML_GetSpecifiedAttributeCount:Int(handle:Byte Ptr)
	Function XML_GetIdAttributeIndex:Int(handle:Byte Ptr)
	Function XML_SetParamEntityParsing:Int(handle:Byte Ptr, code:Int)
	Function XML_UseForeignDTD:Int(handle:Byte Ptr, useDTD:Int)
	Function XML_SetReturnNSTriplet(handle:Byte Ptr, doNST:Int)
	Function XML_DefaultCurrent(handle:Byte Ptr)
	Function XML_GetBuffer:Byte Ptr(handle:Byte Ptr, size:Int)
	Function XML_ParseBuffer:Int(handle:Byte Ptr, bytesRead:Int, isFinal:Int)
	
End Extern



Const XML_STATUS_ERROR:Int = 0
Const XML_STATUS_OK:Int = 1

Const XML_INITIALIZED:Int = 0
Const XML_PARSING:Int = 1
Const XML_FINISHED:Int = 2
Const XML_SUSPENDED:Int = 3

Const XML_ERROR_NONE:Int = 0
Const XML_ERROR_NO_MEMORY:Int = 1
Const XML_ERROR_SYNTAX:Int = 2
Const XML_ERROR_NO_ELEMENTS:Int = 3
Const XML_ERROR_INVALID_TOKEN:Int = 4
Const XML_ERROR_UNCLOSED_TOKEN:Int = 5
Const XML_ERROR_PARTIAL_CHAR:Int = 6
Const XML_ERROR_TAG_MISMATCH:Int = 7
Const XML_ERROR_DUPLICATE_ATTRIBUTE:Int = 8
Const XML_ERROR_JUNK_AFTER_DOC_ELEMENT:Int = 9
Const XML_ERROR_PARAM_ENTITY_REF:Int = 10
Const XML_ERROR_UNDEFINED_ENTITY:Int = 11
Const XML_ERROR_RECURSIVE_ENTITY_REF:Int = 12
Const XML_ERROR_ASYNC_ENTITY:Int = 13
Const XML_ERROR_BAD_CHAR_REF:Int = 14
Const XML_ERROR_BINARY_ENTITY_REF:Int = 15
Const XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF:Int = 16
Const XML_ERROR_MISPLACED_XML_PI:Int = 17
Const XML_ERROR_UNKNOWN_ENCODING:Int = 18
Const XML_ERROR_INCORRECT_ENCODING:Int = 19
Const XML_ERROR_UNCLOSED_CDATA_SECTION:Int = 20
Const XML_ERROR_EXTERNAL_ENTITY_HANDLING:Int = 21
Const XML_ERROR_NOT_STANDALONE:Int = 22
Const XML_ERROR_UNEXPECTED_STATE:Int = 23
Const XML_ERROR_ENTITY_DECLARED_IN_PE:Int = 24
Const XML_ERROR_FEATURE_REQUIRES_XML_DTD:Int = 25
Const XML_ERROR_CANT_CHANGE_FEATURE_ONCE_PARSING:Int = 26
Const XML_ERROR_UNBOUND_PREFIX:Int = 27
Const XML_ERROR_UNDECLARING_PREFIX:Int = 28
Const XML_ERROR_INCOMPLETE_PE:Int = 29
Const XML_ERROR_XML_DECL:Int = 30
Const XML_ERROR_TEXT_DECL:Int = 31
Const XML_ERROR_PUBLICID:Int = 32
Const XML_ERROR_SUSPENDED:Int = 33
Const XML_ERROR_NOT_SUSPENDED:Int = 34
Const XML_ERROR_ABORTED:Int = 35
Const XML_ERROR_FINISHED:Int = 36
Const XML_ERROR_SUSPEND_PE:Int = 37
Const XML_ERROR_RESERVED_PREFIX_XML:Int = 38
Const XML_ERROR_RESERVED_PREFIX_XMLNS:Int = 39
Const XML_ERROR_RESERVED_NAMESPACE_URI:Int = 40

