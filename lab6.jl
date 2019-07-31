using LinearAlgebra

function soltrsup(A, b)
	n = length(b);
	sol = zeros(n)
	for i in 1:n
		j = (n - i) + 1
		t = 0
		for k in (j+1):n
			t += A[j, k] * sol[k]
		end
		sol[j] = (b[j] - t) / A[j,j]
	end
	return sol;
end

function soltrinf(A, b)
	n = length(b);
	sol = zeros(n)
	for i in 1:n
		t = 0
		for k in 1:i-1
			t += A[i, k] * sol[k]
		end
		sol[i] = (b[i] - t) / A[i,i]
	end
	return sol;
end

function egauss(A, b)
	n = length(b);
	A = [A b]
	for i in 1:n-1
		p = i
		pfound = false
		while !pfound && p <= n
		   	if A[i, p] != 0
		   		pfound = true
		   	else
		   		p += 1
		   	end
		end
		if(!pfound)
			return 0
		end
		if p != i
			ep = A[p,:]
			A[p,:] = A[i,:]
			A[i,:] = ep
		end
		for j in i+1:n
			m = A[j,i]/A[i,i]
			A[j,:] = A[j,:] - m*A[i,:]
		end
	end
	if A[n,n] == 0
		return 0
	end
	return A
end

function soleg(A, b)
	n = length(b)
	red = egauss(A, b)
	if red != 0
		return soltrsup(red[:,1:n], red[:,n+1])
	end
end

function sollu(A, b)
	L = lu(A)
	y = soltrinf(L.L,L.P*b)
	return soltrsup(L.U, y)
end

function jacobi(A,b,err,mit)
	n = length(b)
	xs = zeros(n)
	xo = zeros(n)
	for k in 1:mit
		for i in 1:n
			xs[i] = 0
			for j in 1:n
				if j != i
					xs[i] += (-A[i,j] * xo[j])
				end
			end
			xs[i] = (xs[i] + b[i])/A[i,i]
		end
		t = [abs(i) for i in (xo - xs)]
		maxn = t[1]
		for j in 1:n
			maxn = max(maxn, t[j])
			xo[j] = xs[j]
		end
		if maxn < err
			return (xs, k)
		end
	end
	return (xs, mit)
end

function gseidel(A,b,err,mit)
	n = length(b)
	xs = zeros(n)
	xo = zeros(n)
	for k in 1:mit
		for i in 1:n
			xs[i] = 0
			for j in 1:i-1
				xs[i] += (-A[i,j] * xs[j])
			end
			for j in i+1:n
				xs[i] += (-A[i,j] * xo[j])
			end
			xs[i] = (xs[i] + b[i])/A[i,i]
		end
		t = [abs(i) for i in (xo - xs)]
		maxn = t[1]
		for j in 1:n
			maxn = max(maxn, t[j])
			xo[j] = xs[j]
		end
		if maxn < err
			return (xs, k)
		end
	end
	return (xs, mit)
end

ej6a() = [ jacobi(A6,b6,1e-11,50); gseidel(A6,b6,1e-11,50)]
ej6b() = [ jacobi(A6b,b6b,1e-4,5); gseidel(A6b,b6b,1e-4,1500)]

A6 = Float64[
	3 1 1;
	2 6 1;
	1 1 4
]
b6 = [5; 9; 6]

A6b = Float64[
	5 7 6 5;
	7 10 8 7;
	6 8 10 9;
	5 7 9 10
]
b6b = [23; 32; 33; 31]

At = Float64[
	10 -1 2 0;
	-1 11 -1 3;
	2 -1 10 -1;
	0 3 -1 8
]
bt = [6; 25; -11; 15]

A4 = Float64[4 -1 0 -1 0 0;
	 -1 4 -1 0 -1 0;
	  0 -1 4 0 0 -1;
	 -1 0 0 4 -1 0;
	  0 -1 0 -1 4 -1;
	  0 0 -1 0 -1 4]
b1 = [1; 1; 1; 0; 0; 0]
b2 = [1; 1; 1; 1; 1; 1]

sel = [ 8 36 204; 
		36 204 1296; 
		204 1296 8772]
bs = [138 ; 852; 5682]

s  = [ 10 55; 
		55 385]
y = [81; 572]