# HorizontalNavBar

### Description
The 'HorizontalNavBar' component is 
To utilize this tool,
 - The HorizontalNavBar can be added as a normal Group component to your SceneGraph XML or BrightScript.
 - 

### Usage
| Field | Type | Default | Options | Required | AccessPermission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| itemComponentName | string | "ContentNode"  | | false | READ_WRITE | Specifies the name of a XML component for the list items. An instance of this component is created on demand for each visible item of the list. The XML component must define a specific interface as detailed in MarkupList XML component below. |
| content | node | | | true | READ_WRITE | The content of the HorizontalNavBar. This should be a ContentNode with ContentNodes as its children where each one of those represents the content of one "tab" of the HorizontalNavBar. |
| itemSize | vector2d | [0,0] | | false | READ_WRITE | The size of each item in the HorizontalNavBar in the format `[width, height]`. |
| numItems | integer | 12 | | false | READ_WRITE | The total number of items in the HorizontalNavBar. |
| height | float | 115 | | false | READ_WRITE | The height of the HorizontalNavBar overall, can be used in conjunction with the itemWidths field. |
| itemWidths | floatArray | | | false | READ_WRITE | An array of widths for each item, can be used in conjunction with the height field to create a HorizontalNavBar where items are of differing widths. |
| itemSpacings | floatArray | | | false | READ_WRITE | An array of spacings between each item. The first position in the array is the space to the right of the first item in the HorizontalNavBar. |
| drawFocusFeedback | boolean | true | true, false | false | READ_WRITE | Specifies whether or not the focus indicator bitmap is displayed |
| drawFocusFeedbackOnTop | boolean | false | true, false | false | READ_WRITE | Specifies whether the focus indicator bitmap is drawn below or on top of the list items |
| focusBitmapUri | uri | | | false | READ_WRITE | Specifies the bitmap file used for the focus indicator when the list has focus. In most cases, this should be a 9-patch image that specifies both expandable regions as well as margins. Only set this field to specify a custom bitmap that differs in appearance from the default bitmap. | 
| focusFootprintBitmapUri | uri | | | false | READ_WRITE | Specifies the bitmap file used for the focus indicator when the list does not have focus. In most cases, this should be a 9-patch image that specifies both expandable regions as well as margins. Only set this field to specify a custom bitmap that differs in appearance from the default bitmap. |
| focusBitmapBlendColor | color | 0xFFFFFFFF | | false | READ_WRITE | Blend the graphic image specified by focusBitmapUri with the specified color. If set to the default, 0xFFFFFFFF, no color blending will occur. Set this field to show a focus indicator graphic image with a different color than the image specified by focusBitmapUri. |
| focusFootprintBlendColor | color | 0xFFFFFFFF  | | false | READ_WRITE | Blend the graphic image specified by focusFootprintBitmapUri with the specified color. If set to the default, 0xFFFFFFFF, no color blending will occur. Set this field to show a focus footprint indicator graphic image with a different color than the image specified by focusFootprintBitmapUri. |
| itemSelected | integer | | | | READ_ONLY | When a list item is selected, itemSelected is set to the index of the selected item. |
| itemFocused | integer | | | | READ_ONLY | When a list item gains the key focus, set to the index of the focused item. |
| itemUnfocused | integer | | | | READ_ONLY | When an item loses the key focus, set to the index of the unfocused item. |
| jumpToItem | integer | 0 | | false | WRITE_ONLY | When set to a valid item index, this causes the list to immediately update so that the specified index moves into the focus position. |
| animateToItem | integer | | | false | WRITE_ONLY | When set to a valid item index, this causes the list to quickly scroll so that the specified index moves into the focus position. |
| createNextPanelIndex | integer | | | | READ_ONLY | Similar to the createNextPanelIndex field in a ListPanel component, and so it bears the same name despite not using any panels. This field can be used in conjunction with the createNextPanelOnItemFocus or createNextPanelOnItemSelect fields. When either of those fields is true, the createNextPanelIndex will change to the focused or selected index and can be used to show appropriate content. |
| createNextPanelOnItemFocus | boolean | false | | | READ_WRITE | When set to true, the Create Next Panel mechanism is enabled (i.e. the createNextPanelIndex field will be set when a new item receives the focus). When set to false, the Create Next Panel mechanism is disabled (i.e. the createNextPanelIndex field will not be set when a new item receives the focus). |
| createNextPanelOnItemSelect | boolean | true | | | READ_WRITE | When set to true, the Create Next Panel mechanism is enabled (i.e. the createNextPanelIndex field will be set when a new item is selected). When set to false, the Create Next Panel mechanism is disabled (i.e. the createNextPanelIndex field will not be set when a new item is selected).|