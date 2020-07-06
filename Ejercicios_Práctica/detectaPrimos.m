%% Detector de Números Primos

%% Problema: 

% Escriba una función en MATLAB que determine si el número enviado como 
% parámetro es primoo no, regresando 1 lógico o 0 lógico.


%% Notas: 

% Los divisores de un número siempre vienen en pares. 
% Ej. DIV(12) = {(2,6) & (3,4)}
% Por lo tanto, en vez de checar todos los números menores a cierta
% cantidad, se pueden acotar los resultados si solo se busca entre el
% elemento más pequeño de cada par de divisores

% El "punto de equlibrio" entre los divisores "grandes y pequeños" vendría
% siendo la raíz cuadrada del número que se desea analizar, pues la
% magnitud del divisor "más pequeño" y "más grande" se igualan en este
% punto.

% Por último, solo quedaría examinar cada uno de los números que queden por
% debajo de la raíz del número a analizar

%% Algoritmo:

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