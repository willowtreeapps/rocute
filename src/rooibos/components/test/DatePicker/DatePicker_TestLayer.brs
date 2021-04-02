function getDateOrder() as string
    if m.top.useISO = true then return "YMD"
    return tr("MDY")
end function