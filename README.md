# erlsms
Send SMS in Uganda with Ego sms using erlang

Installation
1. Clone this repository
3. cd erlsms
4. rebar3 shell (rebar3 must be installed)

Usage:
Set the username, password and sender in config/sys.config under the sms part. They are strings.
The username and password are those from your Ego sms account

Example:
erlsms_app:send("25678584308", "This tests if erlsms works").
