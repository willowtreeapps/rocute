sub init()
    m.grid = m.top.findNode("grid")
    m.grid.numColumns = 5
    'm.grid.rowSpacings = [0]
    ' setup readonly fields
    'm.grid.observeField("currFocusFeedbackOpacity", "readOnlyFieldChanged")
    'm.grid.observeField("rowItemSelected", "readOnlyFieldChanged")
    'm.grid.observeField("rowItemFocused", "readOnlyFieldChanged")
    'childCount = m.top.getChildCount()
    'm.children = m.top.getChildren(childCount, 0)
    'm.top.observeField("[[children]]", "childrenChanged")
    m.grid.setFocus(true)
end sub

sub childrenChanged(event as object)
    children = event.getData()
    for each child in children
        if child.role = "content" then
            m.grid.content = child
            return
        end if
    end for
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

sub setInnerField(event as Object)
    fieldName = event.getField()
    value = event.getData()
    print fieldName
    if fieldName = "numItems" then
        fieldName = "numColumns"
    else if fieldName = "itemWidths" then
        fieldName = "columnWidths"
    else if fieldName = "itemSpacings" then
        fieldName = "colummSpacings"
    end if
    print m.grid[fieldName]
    m.grid[fieldName] = value
end sub

sub setHeight(event as Object)
    value = event.getData()
    m.grid.rowHeights = [value]
end sub