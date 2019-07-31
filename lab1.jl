#------------------------------------------------------------------------------
function ej1()
a = 1 + 2^(-53);
b = a-1
println(b)
a = 1 + 2^(-52);
b = a-1
println(b)
end
#------------------------------------------------------------------------------
function ej2()
x = 2.0;
z = 0;
while isfinite(x) 
    z = x
    x *= 2
end
println(z)

x = 1.0
while x != 0.0 
    z = x
    x /= 2
end
println(z)
end
#------------------------------------------------------------------------------
function ej3()
x = 0;
while x != 10
	x = x + 0.1 #Esto llega a 9.99999999999998, 10.09999999999998 por lo que no es 10
	# x = x + 0.5 #Esto funciona 0.5 tiene representacion binaria
	# println(x) #Para chusmear porque no daba xd
end
end

function ej4(n)
	x = 1
	cnt = 1
	while(cnt <= n && x != 0)
		x *= cnt
		cnt += 1
	end
	return x
end

ej5(x,y) = x > y ? x : x < y ? y : "jaja"

pot(x,n) = x^n

function ej6(x)
	i = 0
	while(i < 5)
		println(pot(x,i))
		i += 1
	end
end

function ej4a(n)
    i = 1;
    for d = 1:n
        i = i * d;
    end
    return i;
end

function ej7mala(a,b,c)
	det = (b^2 - (4*a*c));
	if(det >= 0)
		rdet = √(det);
		return ((-b + rdet)/(2 * a), (-b - rdet)/(2 * a));
	end
	return "no krnal";
end
