# HorizontalNavBar

### Description
The 'HorizontalNavBar' component is 
To utilize this tool,
 - The HorizontalNavBar can be added as a normal Group component to your SceneGraph XML or BrightScript.
 - 

### Usage
| Field | Type | Default | Options | Required | AccessPermission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| useMonthNames | boolean | true | true, false | false | READ_WRITE | If set to false, months are shown as integers from 1 to 12. If set to true, the month field will go off of localization settings to determine month names. |
| itemComponentName | string | "ContentNode"  | | false | READ_WRITE | |
| content | node | | | true | READ_WRITE | |
| itemSize | vector2d | [0,0] | | false | READ_WRITE | |
| numItems | integer | 12 | | false | READ_WRITE | |
| height | float | 115 | | false | READ_WRITE | | 
| itemWidths | floatArray | | | false | READ_WRITE | |
| itemSpacings | floatArray | | | false | READ_WRITE | |
| drawFocusFeedback | boolean | true | true, false | false | READ_WRITE | |
| drawFocusFeedbackOnTop | boolean | false | true, false | false | READ_WRITE | |
| focusBitmapUri | uri | | | false | READ_WRITE | | 
| focusFootprintBitmapUri | uri | | | false | READ_WRITE | |
| focusBitmapBlendColor | color | 0xFFFFFFFF | | false | READ_WRITE | |
| focusFootprintBlendColor | color | 0xFFFFFFFF  | | false | READ_WRITE | |
| itemSelected | integer | | | | READ_ONLY | |
| itemFocused | integer | | | | READ_ONLY | |
| itemUnfocused | integer | | | | READ_ONLY | |
| jumpToItem | integer | 0 | | | false | READ_WRITE | |
| animateToItem | integer | | | false | READ_WRITE | |
| createNextPanelIndex | integer | | | | READ_ONLY | |
| createNextPanelOnItemFocus | boolean | false | | | | |
| createNextPanelOnItemSelect | boolean | true | | | | |