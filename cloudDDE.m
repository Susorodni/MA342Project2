function dQ = cloudDDE(~, Q, Qdel, lambda, mu, f, alpha, A)
%CLOUDDDE  Right-hand side of the cloud computing DDE system.
%
%   dQ_i/dt = lambda - mu*(1-f)*Q_i(t)
%             + alpha * sum_{j: A(i,j)=1} [ Q_j(t-tau) - Q_i(t-tau) ]
%
%   Q     — current queue lengths  [N x 1]
%   Qdel  — delayed queue lengths  [N x 1]  (at time t-tau, via dde23)
%   A     — adjacency matrix       [N x N]

N  = length(Q);
dQ = zeros(N, 1);
for i = 1:N
    neighbors = find(A(i, :));
    lb = alpha * sum(Qdel(neighbors) - Qdel(i));
    dQ(i) = lambda - mu*(1 - f)*Q(i) + lb;
end
end