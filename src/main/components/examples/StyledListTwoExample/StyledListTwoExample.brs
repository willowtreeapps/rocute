sub init()
    ' Setup
    list = m.top.findNode("StyledListTwoExample")
    m.top.list = list
    m.top.list.observeField("itemFocused", "colorRand")
end sub

sub colorRand()
    colorArray = ["FF0000", "#FFFF00", "#0033CC", "#FF9900", "#00CC00", "#660099"]
    color = m.top.list.focusBitmapBlendColor
    color = colorArray[Rnd(5)]
    m.top.list.focusBitmapBlendColor = color
end sub