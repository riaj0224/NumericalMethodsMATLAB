%% Cifras significativas de PI

%% Problema: 

% Escriba una función que llame a la función del problema anterior 
% sucesivamente n=10 ..... n= 10e7 y despliegue n, el valor aproximado de 
% pi, errorrelativo, y número de cifras significativas de la aproximación.

%% Notas:

% Por la teoría, sabemos que la cantidad de cifras significativas que va a
% producir cualquier cálculo depende de la potencia del error relativo

%% Algortimo:

function approxPI() % Declarar función sin entradas ni salidas

fprintf("n_______ Approx____ Error__ Cs_\n"); % Encabezado de tabla

for j = 1:7 % Potencias de 10 a examinar
    
   m = 10^(j); % Representación de las potencias de 10
   
   approx = sumPI(m); % Se llama a la función que aproxima a PI
   
   errorr = (pi - approx)/pi; % Se calcula error relativo
   
   cs = floor(-(log10(errorr))); % Se obtienen las CS de la aproximación
   
   fprintf("%08d %.8f %f %d\n", m, approx, errorr, cs); % Se imprimen resultados
   
end % Se cierra el FOR
    
    
    function approx = sumPI(n) % Se declaran las entradas y salidas de la función

    approx = 0; % Se inicializa el contador

    for i = 1:n % Número de términos que se van a sumar

        approx  = approx + (4 * ((-1)^(i+1)) * (1/((2*i)-1))); % Sumatoria

    end % Se termina el FOR

    end % Se termina la función

end % Se cierra la función