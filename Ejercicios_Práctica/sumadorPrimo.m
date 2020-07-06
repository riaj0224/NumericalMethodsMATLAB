%% Sumador de primos

%% Problema: 

% Escriba un programa que sume todos los números primos entre 0 y un número
% dado

%% Notas:

% Para este programa se utilizará otra función encontrada en el folder del 
% repositorio: detectaPrimos.m. Para evitar la necesidad de descargar ambos
% archivos, se integrará el código de dicha función dentro de esta.

% Esta función checará todos los números en el intervalo,
% corroborará  que son primos y los sumará al contador si sí son primos.

%% Algoritmo:

function sumaPrima = sumadorPrimo(b) % Se declaran las entradas y salidas 
% de la función

sumaPrima = 0; % Se inicializa sumatoria/contador

for w = 1:b % Intervalo para hacer la sumatoria
   
    esprimo = detectaPrimos(w); % Examinar qué números son primos

        if esprimo == true % Si son primos, sumarlos al contador

            sumaPrima = sumaPrima + w; % Sumatoria

        end

    end

end % Se cierra la función