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

    function esprimo = detectaPrimos(n) % Se inicializa la función con entradas 
    % y salidas

    div = floor(sqrt(n)); % Se calcula la raíz cuadrada y normaliza al número
    % menor más cercano

    analizados = 0; % Contador

    for i = 2:div % Analizar todos los números entre 2 a la raíz cuadrada del 
        % número

        if mod(n,i) == 0 % Si el residuo de alguna división  en el intervalo es 
            %cero, entonces el número dado tiene un divisor

            fprintf("El número no es primo"); % Imprimir la leyenda

            esprimo = false; % El output es seteado a falso

            break % Se para todo el análisis y termina el FOR

        else % Si la división por el número que se está analizando no es entera
            % se incrementa el contador

            analizados = analizados +1; % Incrementa contador

        end % Termina IF

    end % Termina FOR

    if analizados == div - 1 % Si no hubo ningún número que pudiera dividirlo
        % en un número entero, es primo

        fprintf("El número es primo"); % Imprime la leyenda

        esprimo = true; % Setea el output a verdadero

    end %termina IF

    end % Termina función

end % Se cierra la función