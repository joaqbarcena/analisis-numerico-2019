#using PlotlyJS
using Plots
#plotly()
pyplot()
js = false

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

function inewton(x,y,z)
	n = length(x);
	m = length(z);
	w = []
	mtx = zeros(n,n);
	#diff-divs
	for i in 1:n
		mtx[i,1] = y[i];
	end
	for i in 1:n-1
		for j in 1:n-i
			mtx[j, i+1] = (mtx[j,i] - mtx[j+1,i])/(x[j] - x[i + j]);
		end
	end
	for k in 1:m
		wi = 0;
		for i in 1:n
			wj = 1
			for j in 1:i-1
				wj *= (z[k] - x[j])
			end
		    wi += mtx[1,i] * wj
		end
		push!(w,wi);
	end
	return w;
end

f3(x) = 1/x
zj(j) = (24/25) + (j/25)
function ej3()
	#pyplot()
	#plotly()
	xs = [1:5...]
	ys = [f3(x) for x in xs]
	zx = [zj(x) for x in 1:101]
	px = inewton2(xs,ys,zx)
	fz = [f3(x) for x in zx]
	ej3_plot(zx,px,fz)	
end

function ej3_plot(zx,px,fz)
	if(js)
		t1 = scatter(;x=zx,
		              y=fz,
		              mode="lines",
		              name="F(z)")
		t2 = scatter(;x=zx,
		             y=px,
		             mode="lines",
		             name="P(z)")
		layout = Layout(;title="Function vs Polynomial aprox.", 
		                 xaxis_range=[0, 20],
		                 yaxis_range=[0, 2])
		data = [t1, t2]
		plot(data,layout)
	else
		#plt = plot!()
		plot(zx, [fz,px], linewidth=2.0)
		gui()
	end
end

gen(x,r0,r1,ps) = (x*(r1 - r0)/ps) + r0
f4(x) = 1/(1 + 25*(x^2))
x4(x) = gen(x,-1,1,200)
xi(k,n) = 2*(k - 1)/(n - 1)

function ej4()
	xs = [x4(x) for x in 0:199]
	ys = [f4(x) for x in xs]
	for n in 1:15
		zx = [xi(j,n) for j in 1:n+1]
		px = inewton2(xs,ys,zx)
		fz = [f4(x) for x in zx]
		ej4_plot(zx,px,fz)		
	end
end

function ej4_plot(zx,px,fz)
	show(zx)
	print("\n")
	show(fz)
	print("\n")
	show(px)
	print("\n")
	if(js)
		t1 = scatter(;x=zx,
		              y=fz,
		              mode="lines",
		              name="F(z)")
		t2 = scatter(;x=zx,
		             y=px,
		             mode="lines",
		             name="P(z)")
		layout = Layout(;title="Function vs Polynomial aprox.", 
		                 xaxis_range=[0, 20],
		                 yaxis_range=[0, 2])
		data = [t1, t2]
		plot(data,layout)
	else
		plt = plot(zx, [fz,px], linewidth=2.0)
		gui()
	end
end
#{(xi, f(xi))}
#n+1
#i=1 con , i = 1, . . . , n + 1.