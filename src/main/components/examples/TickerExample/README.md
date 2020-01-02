# Ticker

### Description
The 'Ticker' component is a type of news ticker. It scrolls text from right to left. It can run continuously on a loop, or just once. If text is changed while it is running, the current text finishes displaying before the new text starts. 
To utilize this tool,
 - The text field should be the text to display, or the text can be set using the setText function.
 - The text can be appended to using the addText function.
 - The default position of the image is in the lower right corner of the video, with a 10px margin on the right and bottom. 

### Usage
| Field | Type | Default | Options | Required | AccessPermission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| logoUri | uri | | | true | READ_WRITE | The uri of the image. |
| text | string | "" | | true | READ_WRITE | The text to scroll. |
| scrollSpeed | float | 100 | | false | READ_WRITE | The speed of the scrolling in pixels per second. |
| width | float | 1920 | | false | READ_WRITE | The width of the Ticker component. |
| color | color | | | false | READ_WRITE | The text color. |
| font | node | | | false | READ_WRITE | The text's font. |
| vertAlign | string | | | false | READ_WRITE | The text's vertAlign field. |