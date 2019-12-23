# DatePicker

### Description
The 'DatePicker' component is a date picker comprised of three LabelLists, one each for Year, Month, and Day. It has two localization options, one for Date Format which is MDY (Month/Day/Year) in American English and DMY in all other regions. The other is names of the months. Or, there are options to use the ISO standard format YMD and numbered months. Currently this is designed for picking past dates, as it starts in the current year and goes back 150 years. NOTE: All dateTimes are at midnight in UTC. 
To utilize this tool,
 - The DatePicker can be added as a normal Group component to your SceneGraph XML or BrightScript.
 - There are no required fields to get it to work.
 - The read only fields DateTimeISOString and DateTimeSeconds can be used to retrieve the current date as either an ISO formatted string or seconds since epoch, respectively. Both of these can be used to generate a `roDateTime` object using the `fromISO8601String` and `fromSeconds` methods of `ifDateTime`. 
 - Include the translations.xml files in the locale folder in your own project in order to use the localization options.

### Usage
| Field | Type | Default | Options | Required | AccessPermission | Description |
| useISO | boolean | false | true, false | false | READ_WRITE | If set to true, this causes the order of the LabelLists to be in the form of the ISO standard, YMD. If set to false, the labelLists will go off of localization settings to determine order. |
| useMonthNames | boolean | true | true, false | false | READ_WRITE | If set to false, months are shown as integers from 1 to 12. If set to true, the month field will go off of localization settings to determine month names. |
| yearWidth | float | 100 | | false | READ_WRITE | The width of the year LabelList. |
| monthWidth | float | 200 | | false | READ_WRITE | The width of the month LabelList. |
| dayWidth | float | 100 | | false | READ_WRITE | The width of the day LabelList. |
| dateTimeISOString | string | | | | READ_WRITE | Midnight UTC on the date selected as an ISO string. |
| dateTimeSeconds | longinteger | | | | READ_WRITE | Midnight UTC on the date selected as seconds from epoch. |