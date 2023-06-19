%% Método de eliminación Gaussiana:

function X = equipo2_sim_gauss( A, B ) % Se declaran entradas y salidas

sizeA = size(A); % Filas y columnas de la matriz de los coeficientes

sizeB = size(B); % Filas y columnas de la matriz con igualdades

X = []; % Se declara matriz de salida

if sizeA(1) ~= sizeA(2) % Si la matriz no es cuadrada, no se puede resolver
    
  error("Debe de ser una matriz cuadrada"); % Se imprime la razón del error

elseif sizeA(1) ~= sizeB(1) % Si no hay sificientes igualdades en las filas, no se puede resolver
    
  error("A y B deben de tener el mismo número de filas"); % Razón del error
  
end % Fin del IF para condiciones a satisfacer

%% Triangulación

for j = 1:((sizeA(1))-1) % Columnas que se van a manipular con el método
    
    for i = j+1:sizeA(1) % Filas que se van a manipular con el método
        
        m = A(i,j)/A(j,j); % Razón entre la fila actual y la siguiente
        
        A(i,:) = A(i,:) - m*A(j,:); % Se actualizan todos los valores de esa fila
        
        B(i) = B(i) - m*B(j); % Se actualizan los valores de los resultados
        
    end % Fin del FOR
    
end % Fin de la triangulación

X(sizeA(1)) = B(sizeA(1))/A(sizeA(1),sizeA(1)); % Se despeja y escribe el valor de la última variable

%% Sustitución:

for i = sizeA(1)-1:-1:1 % Los valores se van a ir actualizando del penúltimo al primero
    
    sum = 0; % Contador para las sumas del despeje
    
    for j = sizeA(1):-1:i+1 % Se van a sumar los valores hasta antes de la diagonal de la matriz
        
        sum = sum + A(i,j)*X(j); % Se sustituyen los valores de las variables que ya se conocen y se van sumando
        
    end
    
    X(i) = (B(i)- sum)/A(i,i); % El despeje de la variable

end % Fin de la Sustitución

X = X';

end % Fin del programa
