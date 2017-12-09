using JuMP
using CPLEX

N = 4
A = [
0 1 1 1 ;
1 0 1 1 ;
1 1 0 1 ;
1 1 1 0 ;
]
m = Model(solver = CplexSolver())
@variable(m,X[1:N,1:N] >= 0 )
@objective(m, Max, sum{X[i,j]/2, i = 1:N, j = 1:N})

for i = 1:N
	@constraint(m, sum(X[i,j] for j=1:N) <= 1)
end
for j = 1:N
	@constraint(m, sum(X[i,j] for i=1:N) <= 1)
end
for i = 1:N
	for j = 1:N
		@constraint(m, X[i,j] <= A[i,j])
	end
end

status = solve(m)

for i =1:N
	for j = 1:N
		print(getvalue(X[i,j]), ", ")
	end
	println()
end
