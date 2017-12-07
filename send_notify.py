from requests import post
from json import dumps, loads
import argparse
from ConfigParser import SafeConfigParser

parser = argparse.ArgumentParser(description='Short sample app')

parser.add_argument('--message', action="store", dest="message", nargs='+', default="")
parser.add_argument('--command', action="store", dest="command", nargs='+', default="")
parser.add_argument('--notify', action="store", dest="notify", default="room,phone")
parser.add_argument('--ignore', action="store", dest="ignore")
args = parser.parse_args()

conf = SafeConfigParser()
conf.read('send_notify.conf')

data = {"key":conf.get('general', 'key'),
        "username":conf.get('general', 'username')}

if not args.message and not args.command:
    raise Exception("--message or --command must be specified")

data["msg"] = " ".join(args.message)
data["command"] =" ".join(args.command)
data["notify"] = args.notify
if args.ignore:
    data["ignore"] = args.ignore

headers = {'content-type': 'application/json'}
resp = post(conf.get('general', 'target'),
     data=dumps(data),
     headers=headers)
print resp.text
