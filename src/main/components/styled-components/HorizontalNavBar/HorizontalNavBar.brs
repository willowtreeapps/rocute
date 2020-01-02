' Initialization method for the HorizontalNavBar component
sub init()
    m.grid = m.top.findNode("grid")
    m.grid.numColumns = 5
    ' setup readonly fields
    m.grid.observeField("itemUnfocused", "readOnlyFieldChanged")
    m.grid.observeField("itemSelected", "readOnlyFieldChanged")
    m.grid.observeField("itemFocused", "readOnlyFieldChanged")
    m.top.observeField("focusedChild", "focusChanged")
end sub

' A method which gives focus to the markup grid inside of the nav bar when the HorizontalNavBar has focus
'
' @param event a roSGNodeEvent
sub focusChanged(event as object)
    if m.top.hasFocus() = true then
        m.grid.setFocus(true)
    end if
end sub

' A method which updates the read only field `createNextPanelIndex` when focus or selection changes
'
' @param event a roSGNodeEvent
sub readOnlyFieldChanged(event as object)
    fieldName = event.getField()
    value = event.getData()
    m.top[fieldName] = value
    if fieldName="itemFocused" and m.top.createNextPanelOnItemFocus = true then
        m.top.createNextPanelIndex = value
    else if fieldName="itemSelected" and m.top.createNextPanelOnItemSelect = true then
        m.top.createNextPanelIndex = value
    end if
end sub

' A method to set fields on the internal MarkupGrid when fields on the HorizontalNavBar change
'
' @param event a roSGNodeEvent
sub setInnerField(event as object)
    fieldName = event.getField()
    value = event.getData()
    if fieldName = "numItems" then
        fieldName = "numColumns"
    else if fieldName = "itemWidths" then
        fieldName = "columnWidths"
    else if fieldName = "itemSpacings" then
        fieldName = "columnSpacings"
    end if
    m.grid[fieldName] = value
end sub

' A method to set the Height of the navBar
'
' @param event a roSGNodeEvent
sub setHeight(event as object)
    value = event.getData()
    m.grid.rowHeights = [value]
end sub