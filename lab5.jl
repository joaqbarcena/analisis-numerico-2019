function intenumcomp(fun,a,b,N,regla)
x=range(a,stop=b,length=N)
  w=0
  h=(b-a)/N

  if (regla == "trapecio")
    for i=1:(N-1)
      fa=eval(fun(x[i]))
      fb=eval(fun(x[i+1]))
      w=w+ ((fa+fb)/2)*(h)
    end
  elseif (regla == "simpson")
    for i=1:(N-1)
      fa=eval(fun( x[i] ))
      fb=eval(fun(x[i+1]))
      fab=eval(fun((x[i+1]+x[i])/2))
      w=w+ ((h)/6)*(fa+4*fab+fb)
    end
  else
    for i=1:(N-1)
      fab=eval(fun((x[i+1]+x[i])/2))
      w=w+ fab*(h)
    end
  end
  return w
end