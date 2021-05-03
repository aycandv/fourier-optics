function [out] = rect(x)
%RECT returns a rectangle function.
%   returns 1 for absolute value of x is less than 0.5
out = abs(x) <= 1/2;
end
