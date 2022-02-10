%%%-------------------------------------------------------------------
%% @doc erlsms public API
%% sends sms using ego sms uganda
%% @end
%%%-------------------------------------------------------------------

-module(erlsms_app).

-behaviour(application).

-export([start/2, stop/1]).
-export([send/2]).

-define(Username, application:get_env(sms, username)).
-define(Password, application:get_env(sms, password)).
-define(Sender, application:get_env(sms, sender)).

start(_StartType, _StartArgs) ->
    inets:start(),
    erlsms_sup:start_link().

stop(_State) ->
    ok.

send(Number, Message) ->
    Query = uri_string:compose_query([{"number", Number}, {"message", Message}, {"username", ?Username}, {"password", ?Password}, {"sender", ?Sender}]),
    URI = "http://www.egosms.co/api/v1/plain/?"++Query,
    httpc:request(URI).

%% internal functions
