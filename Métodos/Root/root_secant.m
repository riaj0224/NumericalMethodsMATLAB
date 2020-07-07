%% Método de Secante

%% Problema: 

% Use the secant method to estimate the root of f(x)

%% Algoritmo:

function resultados = root_secant(f,xp,x,v) % Se declara la
% función con sus entradas y salidas

error = 1; % Error relativo inicial

i = 0; % contador de iteraciones

tolerancia = 1e-2; % Error relativo aceptable

fprintf("\ni x_______fx_______error___\n"); %Encabezado de las tablas

while abs(error)>tolerancia % Mientras no se cumpla con la tolerancia sigue el ciclo
    
    fx = f(x); % Se evalua la función con el valor actual
    fxp = f(xp); % Se evalua la función con el valor previo

    aprox = x - (((fx-v)*(xp-x))/(fxp-fx)); % Método de Secante
    
    error = (aprox-x)/aprox; % Se calcula el error relativo
    
    xp = x; % El valor actual se vuelve el valor previo
    x = aprox; % El valor actual se vuelve el aproximado 
  
    i = i+1; % Se incrementa el contador
    
    fx = f(x); % Se evalua la función con el valor actual para la tabla
    
    fprintf("%d %.5f %.5f %.5f\n",i,x,fx,error); % Se imprimen resultados
    
end % Se cierra el ciclo

resultados = [x, fx, i]; % Se almacenan resultados

end % se termina función