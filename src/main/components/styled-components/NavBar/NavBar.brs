sub init()
    m.rowList = m.top.findNode("rowList")
    m.rowList.numRows = 1
    m.rowList.showRowLabel = [false]
    m.rowList.showRowCounter = [false]
    m.rowList.observeField("currFocusFeedbackOpacity", "readOnlyFieldChanged")
    m.rowList.observeField("rowItemSelected", "readOnlyFieldChanged")
    m.rowList.observeField("rowItemFocused", "readOnlyFieldChanged")
    m.rowList.setFocus(true)
end sub

sub showPanel(event as Object)
    if m.top.createNextPanelOnItemFocus = false or m.top.createNextPanelOnItemSelect = false then return
    panel = event.getData()
    if m.panelSet = invalid then
        m.panelSet = createObject("roSGNode", "PanelSet")
        m.top.appendChild(m.panelSet)
    end if
    m.panelSet.appendChild(panel)
    panel.setFocus(true)
end sub

sub readOnlyFieldChanged(event as object)
    fieldName = event.getField()
    value = event.getData()
    if left(fieldName, 3) = "row" then
        fieldName = right(fieldName, len(fieldName)-3)
    end if
    fieldName += "_RDO"
    m.top[fieldName] = value
end sub

sub setInnerField(event as Object)
    fieldName = event.getField()
    if fieldName = "focusAnimationStyle" then fieldName = "row" + fieldName
    value = event.getData()
    m.rowList[fieldName] = value
end sub

sub setArrayField(event as Object)
    fieldName = event.getField()
    if fieldName = "itemSize" then fieldName = "row" + fieldName
    fieldName = getArrayFieldName(fieldName)
    value = event.getData()
    valueAsArray = [value]
    m.rowList[fieldName] = valueAsArray
end sub

sub setContent(event as Object)
    innerContent = event.getData()
    outerContent = createObject("roSGNode", "ContentNode")
    outerContent.appendChild(innerContent)
    m.rowList.content = outerContent
end sub

sub setSize(event as Object)
    if event.getField() = "width" then
        m.rowList.itemSpacing[0] = event.getData()
    else if event.getField() = "height" then
        m.rowList.itemSpacing[1] = event.getData()
    end if
end sub

sub setItemSpacing(event as Object)
    widthSpacing = event.getData()
    itemSpacing = [widthSpacing, 0]
    m.rowList.rowItemSpacing[0] = itemSpacing
end sub

sub setJumpToItem(event as Object)
    itemCol = event.getData()
    itemAsArray = [0, itemCol]
    m.rowList.jumpToRowItem = itemAsArray
end sub