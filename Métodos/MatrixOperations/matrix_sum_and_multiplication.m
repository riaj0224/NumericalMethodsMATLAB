%% Suma & Multiplicación de Matrices

function [S, M]= Equipo2_sumANDmult_matrix(A,B) % Se declaran las entrada y salidas.

sizeA = size(A); % Dimensiones de la matriz A

sizeB =size (B); % Dimensiones de la matriz B

S = []; % Inicializa variable

M = []; % Inicializa variable

%% Suma

if sizeA == sizeB % Verifica dimensiones
    
    for i = 1:sizeA(1) % filas

        for j = 1: sizeA(2) % Columnas

        S(i,j) = A(i, j) + B(i,j); % Almacenamiento de la suma

        end
    end
end

    

%% Multiplicación 

if sizeA(2) == sizeB(1) % Condición para ejecutar la multiplicación
    
    for i = 1:sizeA(1) % filas
            
        for k = 1:sizeB(2) % Mover puntero para multiplicar
            
            SM = 0; % Inicializar suma

            for j = 1: sizeB(1) % Mover puntero para multiplicar

                SM = SM +(A(i, j) * B(j,k)); % Acumular sumatoria
                
            end
            
            M(i,k) = SM; % Almacenar resultado
            
        end
            
    end
    
end

end
