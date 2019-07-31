using Plots
pyplot()

function ej2(x,y,intv,sub)
	a, b = intv
	h = (b - a)/sub
	z = []
	push!(z,a)
	i = a
	while i <= b
		#i -> i+h
		push!(z, i + h/2)
		push!(z, i + h)
		i += h
	end
	fs = ilagrange(x,y,z)
	plot(x', y', linewidth=2.0)
	plot(z, fs, linewidth=2.0)
	gui()
	l = 1
	simp = 0
	for i in 1:sub
		simp += (h/6) * (fs[l] * 4fs[l+1] + fs[l+2])
		l = 2*i + 1
	end
	return simp
end

#a b c f g h j
#1 1+1 1+2
#3 3+1 3+2
#5 5+1 5+2

function ilagrange(x,y,z)
	#x,y es un array de tamaño n
	n = length(x);
	m = length(z);
	w = []
	for j in 1:m
		wj = 0;
		for k in 1:n
			L = 1;
			for i in 1:n
				if(i != k)
					L *= (z[j] - x[i]) / (x[k] - x[i]);
				end
			end
			wj += y[k] * L;
		end
		push!(w, wj);
	end
	return w;
end

x = [-1 -0.75 -0.51 -0.27 -0.03 0.21 0.45 0.7 0.94 1.18]
y = [0.02 0.13 0.64 1.2 1.3 1.26 1.02 0.49 0.19 0.08]


lx = [0 1 2 3 4]
ly = [MathConstants.e^i for i in lx]
t() = ej2(lx,ly,(0,4),4)
d() = ej2(x,y,(-1.0,1.0),100)	

function gr()
    xs = [1 2 3 4 5 6 7 8]
    ys = [1.5 4 7.5 12 17.5 24 31.5 40]
    r2(x) = (x^2)/2 + x
    ysf = [r2(k) for k in xs]
    plot(xs', ys', linewidth=2.0)
end