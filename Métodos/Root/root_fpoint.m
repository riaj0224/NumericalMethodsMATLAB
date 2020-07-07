%% Método de punto fijo

%% Problema: 

% Escriba una función en MATLAB para resolver una ecuación mediante el 
% método de Punto Fijo.

%% Algoritmo:

function resultados = root_fpoint(f,x) % Se declara la función 
% con sus entradas y salidas

metodo = input("Quieres realizar el método por error relativo? ('true' para error relativo del 1% && 'false' para por 10 intentos)\n");
% Input del usuario para elegir método de aproximación

i = 0; % Se inicializa contador

tolerancia = 1; % Tolerancia en porcentaje

error_re = 100; % Error inicial

fprintf("i_x________error___\n");% Encabezado de la tabla

if metodo % Método a elegir
    
    while abs(error_re) > tolerancia % Límite de de iteraciones
    
        xn = f(x); % Se utiliza el método

        error_re = ((xn - x)/xn)*100; % Se calcula error relativo porcentual

        x = xn; % Se actualiza valor actual

        i = i + 1; % Se incrementa contador

        fprintf("%d %.6f %.2f\n", i , x, abs(error_re)); % Se imprimen resultados
    
    end % Se termina el while
    
else % Método a elegir
   
    while i<10 % Método por intentos

        xn = f(x); % Se utiliza el método

        error_re = ((xn - x)/xn)*100; % Se calcula el error relativo

        x = xn; % Se actualiza valor

        i = i + 1; % se incrementa contador

        fprintf("%d %.6f %.2f\n", i , x, abs(error_re)); % Se imprimen resultados
    end % Se cierra while

end % Se cierra el if

resultados = [x,i]; % se almacenan resultados
 
end % se cierra la función