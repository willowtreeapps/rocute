sub init()
    m.grid = m.top.findNode("grid")
    m.grid.numRows = 1
    m.grid.rowSpacings = [0]
    ' setup readonly fields
    'm.grid.observeField("currFocusFeedbackOpacity", "readOnlyFieldChanged")
    'm.grid.observeField("rowItemSelected", "readOnlyFieldChanged")
    'm.grid.observeField("rowItemFocused", "readOnlyFieldChanged")

    m.grid.setFocus(true)
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
        fieldName = "columnSpacings"
    end if
    print m.grid[fieldName]
    m.grid[fieldName] = value
end sub

sub setHeight(event as Object)
    value = event.getData()
    m.grid.rowHeights = [value]
end sub