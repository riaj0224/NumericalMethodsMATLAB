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

sumaPrima = 0; % Se inicializa la sumatoria

esprimo = false; % Se inicializa la variable

for n = 0:b % Loop para examinar todos los números en el intervalo con el

    div = floor(sqrt(n)); % Se calcula la raíz cuadrada y normaliza al número
    % menor más cercano

    analizados = 0; % Contador

    for i = 2:div % Analizar todos los números entre 2 a la raíz cuadrada del 
        % número

        if mod(n,i) == 0 % Si el residuo de alguna división  en el intervalo es 
            %cero, entonces el número dado tiene un divisor

            esprimo = false; % El output es seteado a falso

            break % Se para todo el análisis y termina el FOR

        else % Si la división por el número que se está analizando no es entera
            % se incrementa el contador

            analizados = analizados +1; % Incrementa contador

        end % Termina IF

    end % Termina FOR

    if analizados == div - 1 % Si no hubo ningún número que pudiera dividirlo
        % en un número entero, es primo

        esprimo = true; % Setea el output a verdadero

    end %termina IF
    
    if esprimo == true % Si el número resultó primo, se suma al contador
    
    sumaPrima = sumaPrima + n; % Se realiza la suma
    
    end % Se cierra el IF
    
end % Se cierra el FOR

end % Se cierra la función