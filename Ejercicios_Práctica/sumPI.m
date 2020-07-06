%% Aproximador de PI

%% Problema:

% Escriba una función en MATLAB que aproxime el valor de pi mediante la serie 
% siguiente,tomando como parámetro el número de términos a sumar

%% Notas:

% Este programa usará una serie infinita para aproximar a PI, en donde la
% entrada es el número de términos que se desean sumar.

function approx = sumPI(n) % Se declaran las entradas y salidas de la función

approx = 0; % Se inicializa el contador

for i = 1:n % Número de términos que se van a sumar

    approx  = approx + (4 * ((-1)^(i+1)) * (1/((2*i)-1))); % Sumatoria
    
end % Se termina el FOR

end % Se termina la función