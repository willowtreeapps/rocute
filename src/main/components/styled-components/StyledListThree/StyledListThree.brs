sub init()
    ' Setup
    m.top.observeField("itemFocused", "colorRand")
end sub

sub colorRand()
    colorArray = ["FF0000", "#FFFF00", "#0033CC", "#FF9900", "#00CC00", "#660099"]
    color = m.top.focusedColor
    color = colorArray[Rnd(5)]
    m.top.focusedColor = color
end sub