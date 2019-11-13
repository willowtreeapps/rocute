sub init()
    m.rowList = m.top.findNode("rowList")
end sub

sub setInnerField(event as Object)
    fieldName = event.getField()
    if fieldName = "focusAnimationStyle" then fieldName = "row" + fieldName
    value = event.getValue()
    m.rowList[fieldName] = value
end sub

sub setArrayField(event as Object)
    fieldName = event.getField()
    if fieldName = "itemSize" then fieldName = "row" + fieldName
    fieldName = getArrayFieldName(fieldName)
    value = event.getValue()
    valueAsArray = [value]
    m.rowList[fieldName] = valueAsArray
end sub

sub setContent(event as Object)
    innerContent = event.getValue()
    outerContent = createObject("roSGNode", "ContentNode")
    outerContent.appendChild(innerContent)
    m.rowList.content = outerContent
end sub

sub setSize(event as Object)
    if event.getField() = "width" then
        m.rowList.itemSpacing[0] = event.getValue()
    else if event.getField() = "height" then
        m.rowList.itemSpacing[1] = event.getValue()
    end if
end sub

sub setItemSpacing(event as Object)
    widthSpacing = event.getValue()
    itemSpacing = [widthSpacing, 0]
    m.rowList.rowItemSpacing[0] = itemSpacing
end sub

sub setJumpToItem(event as Object)
    itemCol = event.getValue()
    itemAsArray = [0, itemCol]
    m.rowList.jumpToRowItem = itemAsArray
end sub