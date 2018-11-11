function f=dbfilter(n),
%
% Function f=DBFILTER2(n)
%
% The 2n filter coefficients for the Daubechies db(n) wavelet are
% computed by solving a nonlinear system of 2n equations. This
% system of equations is composed of the following conditions:
% (i)   The coefficients f(0),...,f(2n-1) add up to 1. Thus, the
%       area under the scaling function phi(t) becomes equal to 1.

% (ii)  The odd-indexed coefficients add up to 1/2 and the 
%       even-indexed coefficients also add up to 1/2. Thus, the
%       area under the wavelet function psi(t) becomes equal to 0.


% (iii) The coefficients satisfy n-1 double shift bi-orthogonality
%       conditions: 
%        f(0)*f(2k) + f(1)*f(2k+1) + ... + f(2n-2k-1)*f(2n-1) = 0,
%       for all k=1,2,...,n-1. This ensures orthogonality of the 
%       basis generated from the shifted scaling function phi(t).
% (iv)  The coefficients satisfy n conditions which express that
%       the point z=-1 yields a zero of order n of the transfer
%       function of the lowpass filter given by:
%        F(1/z) = f(0) + f(1) z + f(2) z^2 + ... + f(n) z^n.
%       Condition (ii) already ensures that z=-1 yields a zero.
%       Repeated differentiation of F(z) produces n-1 additional
%       conditions.
%
% The system of equations is solved numerically using the function
% fsolve from the optimization toolbox. The computed filter
% coefficients are stored in the 2n-vector f.
%
% The termination tolerance on the function value is set to 10^(-8)
% and the number of function calls is limited to 50000 to make sure
% the optimization routine does not run too long.
op=optimset('TolFun',10^(-8),'MaxIter',1000000000,'MaxFunEvals',1000000000);
% fsolve is told to solve for the function dbfreq with all coefficients
% initially set to 1/(2n) to ensure some basic constraints
[f,fval]=fsolve('dbfeq',ones(1,2*n)/(2*n),op);

% End of function DBFILTER2.

return;

% -----------------------------------------------------------------