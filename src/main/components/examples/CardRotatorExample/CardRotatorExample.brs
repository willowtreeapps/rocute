sub init()
    m.CardRotatorExample = m.top.findNode("CardRotatorExample")
    m.CardRotatorExample.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

sub handleFocus(event as object)
    if m.top.isInFocusChain() then
        m.CardRotatorExample.setFocus(true)
    end if
end sub