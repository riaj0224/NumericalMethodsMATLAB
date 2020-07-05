%% Función de coseno mediante la serie de Taylor

%% Problema:

% Escriba una función en MATLAB que calcule el coseno de un ángulo mediante 
% la serie de Taylor hasta una potencia enviada también como parámetro.

%% Notas:

% Esta función calcula el valor de una función de coseno mediante la serie
% de Taylor. Sus entradas son el valor del ángulo en grados y la potencia
% hasta la cual se desea realizar la sumatoria de la serie. 

% No obstante, como la serie de Taylor requiere que el ángulo esté en
% radianes, se realiza una pequeña conversión de unidades y se procede a
% representar la serie con un loop "for".

% Dado que en la serie de Taylor SÍ existen los términos con exponente
% impar (pero estos tienen un coeficiente de cero), con la función floor se
% normaliza la potencia de entrada a la potencia par menormás cercana.

%% Algoritmo:

function resultado = cosenoTaylor(anguloGrados, potencia) % Se declaran las 
% entradas y salidas de la función

anguloRadianes = (pi * anguloGrados)/180; % Conversión de unidades a 
%radianes

exponente = 2 * floor(potencia/2); % Se normalizan las potencias a siempre
% ser par

resultado = 0; % Se inicializa la sumatoria

fprintf("i_valor____\n"); % Encabezado de la tabla de las iteraciones

for i = (0:2:exponente) % Se realizará la sumatoria de 2 en dos hasta 
    % llegar a la potencia deseada
    
    resultado = resultado + (((-1)^(i/2))*(((anguloRadianes)^i)/factorial(i)));
    % Representación de la serie en términos de i
    
    fprintf("%d %d\n",i, resultado); % Se imprimen los resultados de cada 
    %iteración
    
end % Se cierra el FOR

end % Se cierra la función