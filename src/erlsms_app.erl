%%%-------------------------------------------------------------------
%% @doc erlsms public API
%% sends sms using ego sms uganda
%% @end
%%%-------------------------------------------------------------------

-module(erlsms_app).

-behaviour(application).

-export([start/2, stop/1]).
-export([send/2]).

-define(Username, begin {ok, Username} = application:get_env(sms, username), Username end).
-define(Password, begin {ok, Password} = application:get_env(sms, password), Password end).
-define(Sender, begin {ok, Sender} = application:get_env(sms, sender),  Sender end).

start(_StartType, _StartArgs) ->
    inets:start(),
    erlsms_sup:start_link().

stop(_State) ->
    ok.

send(Number, Message) ->
    PlusLessNumber = lists:append( string:replace(Number, "+", "") ),
    Query = uri_string:compose_query([{"number", PlusLessNumber}, {"message", Message}, {"username", ?Username}, {"password", ?Password}, {"sender", ?Sender}]),
    URI = "http://www.egosms.co/api/v1/plain/?"++Query,
    httpc:request(URI).

%% internal functions
