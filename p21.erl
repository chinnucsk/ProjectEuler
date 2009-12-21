-module(p21).

-export([answer/0]).

%% Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
%% If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
%% For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284.
%% The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
%% Evaluate the sum of all the amicable numbers under 10000.

% relies on rvirding/rb reb-black tree implementation: http://github.com/rvirding/rb
answer() ->
    Nums = lists:seq(1,10000),
    Ds = lists:map(fun(N) -> {N, d(N)} end, Nums),
    Tree = rbdict:from_list(Ds),
    Amicable = lists:filter(fun(X) -> {ok, Y} = rbdict:find(X, Tree), { ok, X} =:= rbdict:find(Y, Tree) andalso X =/= Y end, Nums),
    lists:sum(Amicable).                

d(N) -> lists:sum(proper_divisors(N)).

proper_divisors(N) ->
    lists:usort([1 | lists:flatten([ [X, N div X] || X <- lists:seq(2, round(math:sqrt(N)) + 1), N rem X =:= 0, X < N])]).
