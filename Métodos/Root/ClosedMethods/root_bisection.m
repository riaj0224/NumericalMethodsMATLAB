function resultados = root_bisection(f, a, b, v)

syms x
error = 1; % Error relativo inicial
i = 0; % Número de iteraciones
canterior = b;
tolerancia = 1e-4;

fprintf("\ni r_______error_____\n"); %Encabezado de las tablas
while abs(error) > tolerancia
    fa = (feval(f,a)-v);
    fb = (feval(f,b)-v);
    
    c = (a+b)/2;
    fc = (feval(f,c)-v);
    
    error = (c - canterior)/c;
    canterior = c;
    
    i = i + 1;
    
    if sign(fc) == sign(fa) % comparación con el límite inferior
        a = c;
    end  
    if sign(fc) == sign(fb) %comparación con el límite superior
        b = c;
    end
    
    fprintf ("%d %f %f\n", i, c, error)
   
end

fc = (feval(f,c)-v);

resultados = [c, fc, i];

end
