sub init()
    m.datePicker = m.top.findNode("datePicker")
    m.top.observeField("focusedChild", "giveFocus")
end sub

sub giveFocus(event as object)
    if m.top.isInFocusChain() and m.datePicker.hasFocus() = false then
        m.datePicker.setFocus(true)
    end if
end sub