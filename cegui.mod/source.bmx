' Copyright (c) 2008 Bruce A Henderson
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
Import BRL.Keycodes

Import "../libxml.mod/src/*.h"
Import "../../pub.mod/freetype.mod/include/*.h"
Import "../regex.mod/src/*.h"
Import "../freeimage.mod/src/*.h"

?macos
Import "-framework CoreFoundation"
Import "cegui/src/implementations/mac/*.h"
?

'
Import "cegui/include/*.h"

Import "cegui/src/CEGUIBase.cpp"
Import "cegui/src/CEGUIBoundSlot.cpp"
Import "cegui/src/CEGUIColourRect.cpp"
Import "cegui/src/CEGUIConfig_xmlHandler.cpp"
Import "cegui/src/CEGUICoordConverter.cpp"
Import "cegui/src/CEGUIDataContainer.cpp"
Import "cegui/src/CEGUIDefaultLogger.cpp"
Import "cegui/src/CEGUIDefaultResourceProvider.cpp"
Import "cegui/src/CEGUIDynamicModule.cpp"
Import "cegui/src/CEGUIEvent.cpp"
Import "cegui/src/CEGUIEventArgs.cpp"
Import "cegui/src/CEGUIEventSet.cpp"
Import "cegui/src/CEGUIEventSignal.cpp"
Import "cegui/src/CEGUIEventSignalSet.cpp"
Import "cegui/src/CEGUIExceptions.cpp"
Import "cegui/src/CEGUIFactoryModule.cpp"
Import "cegui/src/CEGUIFont.cpp"
Import "cegui/src/CEGUIFontManager.cpp"
Import "cegui/src/CEGUIFontProperties.cpp"
Import "cegui/src/CEGUIFont_xmlHandler.cpp"
Import "cegui/src/CEGUIFreeTypeFont.cpp"
Import "cegui/src/CEGUIGlobalEventSet.cpp"
Import "cegui/src/CEGUIGUILayout_xmlHandler.cpp"
Import "cegui/src/CEGUIImage.cpp"
Import "cegui/src/CEGUIImageCodec.cpp"
Import "cegui/src/CEGUIImageset.cpp"
Import "cegui/src/CEGUIImagesetManager.cpp"
Import "cegui/src/CEGUIImageset_xmlHandler.cpp"
Import "cegui/src/CEGUILogger.cpp"
Import "cegui/src/CEGUIMouseCursor.cpp"
Import "cegui/src/CEGUIPixmapFont.cpp"
Import "cegui/src/CEGUIProperty.cpp"
Import "cegui/src/CEGUIPropertyHelper.cpp"
Import "cegui/src/CEGUIPropertySet.cpp"
Import "cegui/src/CEGUIRect.cpp"
Import "cegui/src/CEGUIRenderCache.cpp"
Import "cegui/src/CEGUIRenderer.cpp"
Import "cegui/src/CEGUIScheme.cpp"
Import "cegui/src/CEGUISchemeManager.cpp"
Import "cegui/src/CEGUIScheme_xmlHandler.cpp"
Import "cegui/src/CEGUIScriptModule.cpp"
Import "cegui/src/CEGUISize.cpp"
Import "cegui/src/CEGUIString.cpp"
Import "cegui/src/CEGUISubscriberSlot.cpp"
Import "cegui/src/CEGUISystem.cpp"
Import "cegui/src/CEGUITextUtils.cpp"
Import "cegui/src/CEGUITexture.cpp"
Import "cegui/src/CEGUIWindow.cpp"
Import "cegui/src/CEGUIWindowFactory.cpp"
Import "cegui/src/CEGUIWindowFactoryManager.cpp"
Import "cegui/src/CEGUIWindowManager.cpp"
Import "cegui/src/CEGUIWindowProperties.cpp"
Import "cegui/src/CEGUIWindowRenderer.cpp"
Import "cegui/src/CEGUIWindowRendererManager.cpp"
Import "cegui/src/CEGUIXMLAttributes.cpp"
Import "cegui/src/CEGUIXMLHandler.cpp"
Import "cegui/src/CEGUIXMLParser.cpp"
Import "cegui/src/CEGUIXMLSerializer.cpp"
Import "cegui/src/CEGUIcolour.cpp"
Import "cegui/src/elements/CEGUIBaseFactories.cpp"
Import "cegui/src/elements/CEGUIButtonBase.cpp"
Import "cegui/src/elements/CEGUICheckbox.cpp"
Import "cegui/src/elements/CEGUIClippedContainer.cpp"
Import "cegui/src/elements/CEGUICheckboxProperties.cpp"
Import "cegui/src/elements/CEGUICombobox.cpp"
Import "cegui/src/elements/CEGUIComboboxProperties.cpp"
Import "cegui/src/elements/CEGUIComboDropList.cpp"
Import "cegui/src/elements/CEGUIDragContainer.cpp"
Import "cegui/src/elements/CEGUIDragContainerProperties.cpp"
Import "cegui/src/elements/CEGUIEditbox.cpp"
Import "cegui/src/elements/CEGUIEditboxProperties.cpp"
Import "cegui/src/elements/CEGUIFrameWindow.cpp"
Import "cegui/src/elements/CEGUIFrameWindowProperties.cpp"
Import "cegui/src/elements/CEGUIGUISheet.cpp"
Import "cegui/src/elements/CEGUIItemEntry.cpp"
Import "cegui/src/elements/CEGUIItemEntryProperties.cpp"
Import "cegui/src/elements/CEGUIItemListBase.cpp"
Import "cegui/src/elements/CEGUIItemListBaseProperties.cpp"
Import "cegui/src/elements/CEGUIItemListbox.cpp"
Import "cegui/src/elements/CEGUIItemListboxProperties.cpp"
Import "cegui/src/elements/CEGUIListbox.cpp"
Import "cegui/src/elements/CEGUIListboxItem.cpp"
Import "cegui/src/elements/CEGUIListboxProperties.cpp"
Import "cegui/src/elements/CEGUIListboxTextItem.cpp"
Import "cegui/src/elements/CEGUIListHeader.cpp"
Import "cegui/src/elements/CEGUIListHeaderProperties.cpp"
Import "cegui/src/elements/CEGUIListHeaderSegment.cpp"
Import "cegui/src/elements/CEGUIListHeaderSegmentProperties.cpp"
Import "cegui/src/elements/CEGUIMenubar.cpp"
Import "cegui/src/elements/CEGUIMenuBase.cpp"
Import "cegui/src/elements/CEGUIMenuBaseProperties.cpp"
Import "cegui/src/elements/CEGUIMenuItem.cpp"
Import "cegui/src/elements/CEGUIMultiColumnList.cpp"
Import "cegui/src/elements/CEGUIMultiColumnListProperties.cpp"
Import "cegui/src/elements/CEGUIMultiLineEditbox.cpp"
Import "cegui/src/elements/CEGUIMultiLineEditboxProperties.cpp"
Import "cegui/src/elements/CEGUIPopupMenu.cpp"
Import "cegui/src/elements/CEGUIPopupMenuProperties.cpp"
Import "cegui/src/elements/CEGUIProgressBar.cpp"
Import "cegui/src/elements/CEGUIProgressBarProperties.cpp"
Import "cegui/src/elements/CEGUIPushButton.cpp"
Import "cegui/src/elements/CEGUIRadioButton.cpp"
Import "cegui/src/elements/CEGUIRadioButtonProperties.cpp"
Import "cegui/src/elements/CEGUIScrollablePane.cpp"
Import "cegui/src/elements/CEGUIScrollablePaneProperties.cpp"
Import "cegui/src/elements/CEGUIScrollbar.cpp"
Import "cegui/src/elements/CEGUIScrollbarProperties.cpp"
Import "cegui/src/elements/CEGUIScrolledContainer.cpp"
Import "cegui/src/elements/CEGUIScrolledContainerProperties.cpp"
Import "cegui/src/elements/CEGUIScrolledItemListBase.cpp"
Import "cegui/src/elements/CEGUIScrolledItemListBaseProperties.cpp"
Import "cegui/src/elements/CEGUISlider.cpp"
Import "cegui/src/elements/CEGUISliderProperties.cpp"
Import "cegui/src/elements/CEGUISpinner.cpp"
Import "cegui/src/elements/CEGUISpinnerProperties.cpp"
Import "cegui/src/elements/CEGUITabButton.cpp"
Import "cegui/src/elements/CEGUITabControl.cpp"
Import "cegui/src/elements/CEGUITabControlProperties.cpp"
Import "cegui/src/elements/CEGUIThumb.cpp"
Import "cegui/src/elements/CEGUIThumbProperties.cpp"
Import "cegui/src/elements/CEGUITitlebar.cpp"
Import "cegui/src/elements/CEGUITitlebarProperties.cpp"
Import "cegui/src/elements/CEGUITooltip.cpp"
Import "cegui/src/elements/CEGUITooltipProperties.cpp"
Import "cegui/src/elements/CEGUIGroupBox.cpp"
Import "cegui/src/elements/CEGUITree.cpp"
Import "cegui/src/elements/CEGUITreeItem.cpp"
Import "cegui/src/elements/CEGUITreeProperties.cpp"

Import "cegui/src/falagard/CEGUIFalComponentBase.cpp"
Import "cegui/src/falagard/CEGUIFalDimensions.cpp"
Import "cegui/src/falagard/CEGUIFalFrameComponent.cpp"
Import "cegui/src/falagard/CEGUIFalImageryComponent.cpp"
Import "cegui/src/falagard/CEGUIFalImagerySection.cpp"
Import "cegui/src/falagard/CEGUIFalLayerSpecification.cpp"
Import "cegui/src/falagard/CEGUIFalNamedArea.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyDefinition.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyDefinitionBase.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyLinkDefinition.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyInitialiser.cpp"
Import "cegui/src/falagard/CEGUIFalSectionSpecification.cpp"
Import "cegui/src/falagard/CEGUIFalStateImagery.cpp"
Import "cegui/src/falagard/CEGUIFalTextComponent.cpp"
Import "cegui/src/falagard/CEGUIFalWidgetComponent.cpp"
Import "cegui/src/falagard/CEGUIFalWidgetLookFeel.cpp"
Import "cegui/src/falagard/CEGUIFalWidgetLookManager.cpp"
Import "cegui/src/falagard/CEGUIFalXMLEnumHelper.cpp"
Import "cegui/src/falagard/CEGUIFalagard_xmlHandler.cpp"

'
Import "cegui/WindowRendererSets/Falagard/include/*.h"
Import "cegui/WindowRendererSets/Falagard/src/FalButton.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalToggleButton.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalDefault.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalEditbox.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalFrameWindow.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalItemEntry.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalItemListbox.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalListHeader.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalListHeaderProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalListHeaderSegment.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalListbox.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalMenubar.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalMenuItem.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalModule.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalMultiColumnList.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalMultiLineEditbox.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalPopupMenu.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalProgressBar.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalProgressBarProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalScrollablePane.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalScrollbar.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalScrollbarProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalSlider.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalSliderProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalStatic.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalStaticImage.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalStaticImageProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalStaticProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalStaticText.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalStaticTextProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalSystemButton.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalTabButton.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalTabControl.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalTabControlProperties.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalTitlebar.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalTooltip.cpp"
Import "cegui/WindowRendererSets/Falagard/src/FalTree.cpp"

' xml parser
Import "cegui/XMLParserModules/TinyXMLParser/ceguitinyxml/*.h"
Import "cegui/XMLParserModules/TinyXMLParser/ceguitinyxml/tinystr.cpp"
Import "cegui/XMLParserModules/TinyXMLParser/ceguitinyxml/tinyxmlparser.cpp"
Import "cegui/XMLParserModules/TinyXMLParser/ceguitinyxml/tinyxml.cpp"
Import "cegui/XMLParserModules/TinyXMLParser/ceguitinyxml/tinyxmlerror.cpp"

Import "cegui/XMLParserModules/TinyXMLParser/*.h"
Import "cegui/XMLParserModules/TinyXMLParser/CEGUITinyXMLParser.cpp"
Import "cegui/XMLParserModules/TinyXMLParser/CEGUITinyXMLParserModule.cpp"

' ogl renderer
Import "cegui/RendererModules/*.h"
Import "cegui/RendererModules/OpenGLGUIRenderer/GLEW/*.h"
Import "cegui/RendererModules/OpenGLGUIRenderer/GLEW/src/glew.c"

Import "cegui/RendererModules/OpenGLGUIRenderer/openglrenderer.cpp"
Import "cegui/RendererModules/OpenGLGUIRenderer/opengltexture.cpp"

' freeimage
Import "cegui/ImageCodecModules/FreeImageImageCodec/*.h"
Import "cegui/ImageCodecModules/FreeImageImageCodec/CEGUIFreeImageImageCodec.cpp"
Import "cegui/ImageCodecModules/FreeImageImageCodec/CEGUIFreeImageImageCodecModule.cpp"

?macos
Import "cegui/src/implementations/mac/macPlugins.cpp"
?

Import "*.h"
Import "glue.cpp"
