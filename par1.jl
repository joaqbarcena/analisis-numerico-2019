function deriv(f,x0)
	h = 0.00001;
	return (f(x0 + h) - f(x0)) / h;
	#y1 - y0 / x1 - x0
	#y1 = f(x1) = f(x0 + h)
	#y0 = f(x0) = f(x0)
	#f(x0 + h) - f(x0) / (x0 + h) - x0 => .../h
end

function m(f,x0,x1)
	return (f(x1) - f(x0))/(x1-x0)
end

function rsec(fun,x0,x1,err,mit)
	hx = [];
	hf = [];
	i = 0;
	while(i < mit && abs(fun(x1)) >= err && (abs(x1-x0)/abs(x0)) >= err)
		push!(hx,x1);
		push!(hf,fun(x1));
		x1c = x1
		x1 = x1 - (fun(x1)*(x1 - x0))/(fun(x1) - fun(x0));
		x0 = x1c
		i += 1
	end
	push!(hx,x1);
	push!(hf,fun(x1))
	return (hx,hf)
end

function rsec1(fun,x0,x1,err,mit)
	hx = Float64[];
	hf = Float64[];
	i = 0;
	while(i < mit && abs(fun(x1)) >= err && (abs(x1-x0)/abs(x0)) >= err)
		push!(hx,x1);
		push!(hf,fun(x1));
		x1c = x1
		x1 = x1 - (fun(x1)/m(fun,x0,x1));
		x0 = x1c
		i += 1
	end
	push!(hx,x1);
	push!(hf,fun(x1));
	return (hx,hf)
end

ln(x)=log(MathConstants.e,x)
funpar(x) = x^3 + 2(x^2) + 10x - 20
#f(x)/1 : (f(x) - f(z)) / (x - z)
# f(x)(x-z) / f(x) - f(z)
funb(x) = (1/2)MathConstants.e^x - sin(x + 1)
function rbisec(fun,I,err,mit)
	j(i,j) = (fun(i) * fun(j)) < 0;
	p(k,h) = (k + h) / 2;
	hx = Float64[];
	hf = Float64[];
	a = I[1];
	b = I[2];
	k = b;
	i = 0;
	while(i < mit && abs(fun(k)) > err && j(a,b))
		k = p(a,b);
		push!(hx, k);
		push!(hf, fun(k));
		if(j(a,k))
			b = k;
		else
			a = k;
		end
		i += 1;
	end
	return(hx,hf)
end