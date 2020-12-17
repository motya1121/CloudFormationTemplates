import json
import urllib.request
import sys

args = sys.argv

VPN_IP_ADDR = args[1]
USER_NAME = args[2]
VPN_USER_PW = args[3]
VPN_KEY = args[4]
NOTICE_TYPE = args[5]
NOTICE_TOKEN = args[6]


def slack():
    post_data = {
        'blocks': [{
            "type": "header",
            "text": {
                "type": "plain_text",
                "text": "VPN server completed!",
                "emoji": True
            }
        }, {
            "type": "section",
            "text": {
                "type":
                    "plain_text",
                "text":
                    "Server IP addr: {}\nUser Name: {}\nUser PW: {}\nVPN Key: {}".format(
                        VPN_IP_ADDR, USER_NAME, VPN_USER_PW, VPN_KEY)
            }
        }]
    }
    headers = {'Content-Type': 'application/json'}
    req = urllib.request.Request("https://hooks.slack.com/services/" + NOTICE_TOKEN,
                                 data=json.dumps(post_data).encode('utf-8'),
                                 headers=headers,
                                 method='POST')
    urllib.request.urlopen(req)


def line():
    payload = {
        "message":
            "\nServer IP addr: {}\nUser Name: {}\nUser PW: {}\nVPN Key: {}".format(VPN_IP_ADDR, USER_NAME, VPN_USER_PW,
                                                                                   VPN_KEY)
    }
    url = "https://notify-api.line.me/api/notify"
    headers = {"Authorization": "Bearer " + NOTICE_TOKEN}
    req = urllib.request.Request(url=url,
                                 data=urllib.parse.urlencode(payload).encode("utf-8"),
                                 headers=headers,
                                 method='POST')
    urllib.request.urlopen(req)


if NOTICE_TYPE in ["slack", "Slack"]:
    slack()
elif NOTICE_TYPE in ["line", "Line"]:
    line()
