function deriv(f,x0)
	h = 0.00001;
	return (f(x0 + h) - f(x0)) / h;
end

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

function rnewton(fun,a,err,mit)
	hx = Float64[];
	hf = Float64[];
	i = 0;
	k = abs(fun(a)) > err;
	while(i < mit && k)
		k = abs(fun(a)) > err;
		push!(hx,a);
		push!(hf,fun(a));
		a = a - (fun(a)/deriv(fun,a));
		i += 1
	end
	return (hx,hf)
end

fun_lab2ej2a(x) = tan(x) -  2 * x;
fun_lab2ej2b(x) = x^2  - 3;