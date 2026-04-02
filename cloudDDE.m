function dQ = cloudDDE(t, Q, Qdel, lambda, mu, f, alpha, A, tstop)
%CLOUDDDE  Right-hand side of the cloud computing DDE system.
%
%   dQ_i/dt = lambda - mu*(1-f)*Q_i(t)
%             + alpha * sum_{j: A(i,j)=1} [ Q_j(t-tau) - Q_i(t-tau) ]
%
%   Q     — current queue lengths  [N x 1]
%   Qdel  — delayed queue lengths  [N x 1]  (at time t-tau, via dde23)
%   A     — adjacency matrix       [N x N]
if t >= tstop
    lam = 0;
else
    lam = lambda;
end
N  = length(Q);
dQ = zeros(N, 1);
for i = 1:N
    neighbors = find(A(i, :));
    lb = alpha * sum(floor(Qdel(neighbors)) - floor(Qdel(i)));
    dQ(i) = lam - floor(mu*(1 - f)*floor(Q(i)) + lb);
end
end