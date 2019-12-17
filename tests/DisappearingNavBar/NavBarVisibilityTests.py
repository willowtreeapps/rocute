########################################################################
# Copyright 2019 Roku, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
########################################################################

from webDriver import WebDriver
import json


def get_label_text_from_element(element):
    if element["XMLName"]["Local"] == "Label":
        for attr in element["Attrs"]:
            if attr["Name"]["Local"] == "text":
                return attr["Value"]
        return None
    elif element["Nodes"] is not None:
        for node in element["Nodes"]:
            text = get_label_text_from_element(node)
            if text is not None:
                return text
    return None


def get_selected_element():
    selected_element = web_driver.get_active_element()
    selected_content = json.loads(selected_element.text)
    while selected_content["value"]["XMLName"]["Local"] != "RenderableNode":
        selected_element = web_driver.get_active_element()
        selected_content = json.loads(selected_element.text)
    return selected_content["value"]


web_driver = WebDriver("192.168.103.21")
web_driver.launch_the_channel("dev")
web_driver.verify_is_screen_loaded({"elementData": [{
    "using": "text",
    "value": "rocute"
}]})
# web_driver.verify_is_screen_loaded({"elementData": [{
#     "using": "tag",
#     "value": "LabelList"
# }]})
# web_driver.verify_is_screen_loaded({"elementData": [{
# 	"using": "attr",
#    "attribute": "id",
# 	"value": "componentList"
# }]})

activeElement = get_selected_element()

labelText = get_label_text_from_element(activeElement)

while labelText != "DisappearingNavBar" and labelText is not None:
    web_driver.press_btn("up")
    activeElement = get_selected_element()
    labelText = get_label_text_from_element(activeElement)

web_driver.press_btn("select")
web_driver.verify_is_screen_loaded({"elementData": [{
    "using": "text",
    "value": "Barack Gates, Bill Obama"
}]})

res = web_driver.verify_is_screen_loaded({"elementData": [{
    "using": "text",
    "value": "Authenticate to watch"
}]}, False, 2)
if res == False:
    res = web_driver.verify_is_screen_loaded({"elementData": [{
        "using": "text",
        "value": "Play"
    }]})
    web_driver.press_btn("select")
else:
    web_driver.press_btn("select")
    web_driver.verify_is_screen_loaded({"elementData": [{
        "using": "text",
        "value": "Please enter your username"
    }]})
    web_driver.send_word("user")
    web_driver.send_button_sequence(["down", "down", "down", "down", "select"])
    web_driver.verify_is_screen_loaded({"elementData": [{
        "using": "text",
        "value": "Please enter your password"
    }]})
    web_driver.send_word("pass")
    web_driver.send_button_sequence(["down", "down", "down", "down", "select"])

web_driver.quiet()
