%% Método de Newton-Raphson
function resultados = root_newtonraphson(f,xi,v)

syms x
df = matlabFunction( diff(f(x)) ); % Derivada de la función
error = 1; % Error relativo inicial
i = 0; % Número de iteraciones
fprintf("\ni ev_______error_____\n"); % Encabezado de las tablas
tolerancia = 1e-2; % Error porcentual tolerable,

while abs(error)>tolerancia % Mientras no se cumpla con la tolerancia sigue el ciclo
    
    fev = feval(f,xi); % Se evalua la función original
    dfev = feval(df,xi); % Se evalua la derivada
    aprox = xi - ((fev-v)/dfev); % Método de Newton
    error = (aprox-xi)/aprox; % Se calcula el error
    xi = aprox; % Se asigna el resultado del método al valor a evaluar 
    fev = feval(f,xi); % Se evalua la función original (solo para la tabla)
    i = i+1; % Se incrementa el contador
    fprintf("%d %f %f\n",i,xi,error); % Se imprimen resultados
    
    resultados = [xi, fev, i]; % Se almacenan resultados
    
end % Se cierra el ciclo
end % se cierra función

