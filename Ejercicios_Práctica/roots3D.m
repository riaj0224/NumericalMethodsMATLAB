%% Fórmula cúbica general

%% Problema: 

% Cicharronera Plus. Escriba una función en MATLAB que encuentre las raices 
% de la ecuación cúbica ax³+bx²+cx+d=0

%% Notas:

% Para este programa simplemente se buscó en Google fórmula general cúbica
% y se trascribió en su forma más general para calcular partes complejas
% también.

%% Algoritmo:

function roots = roots3D(a,b,c,d) % Se declaran las entradas y salidas de 
% la función

% Raíces del polinomio con la fórmula general
    x1 = -b/(3*a) - (2^(1/3)*(-b^2 + 3*a*c))/(3*a*(-2*b^3 + 9*a*b*c - 27*a^2*d + sqrt(4*(-b^2 + 3*a*c)^3 + (-2*b^3 + 9*a*b*c - 27*a^2*d)^2))^(1/3)) + (-2*b^3 + 9*a*b*c - 27*a^2*d + sqrt(4*(-b^2 + 3*a*c)^3 + (-2*b^3 + 9*a*b*c - 27*a^2*d)^2))^(1/3)/(3*2^(1/3)*a);
    x2 = -b/(3*a) + ((1 + 1i*sqrt(3))*(-b^2 + 3*a*c))/(3*2^(2/3)*a*(-2*b^3 + 9*a*b*c - 27*a^2*d + sqrt(4*(-b^2 + 3*a*c)^3 + (-2*b^3 + 9*a*b*c - 27*a^2*d)^2))^(1/3)) - (1 - 1i*sqrt(3))*(-2*b^3 + 9*a*b*c - 27*a^2*d + sqrt(4*(-b^2 + 3*a*c)^3 + (-2*b^3 + 9*a*b*c - 27*a^2*d)^2))^(1/3)/(6*2^(1/3)*a);
    x3 = -b/(3*a) + ((1 - 1i*sqrt(3))*(-b^2 + 3*a*c))/(3*2^(2/3)*a*(-2*b^3 + 9*a*b*c - 27*a^2*d + sqrt(4*(-b^2 + 3*a*c)^3 + (-2*b^3 + 9*a*b*c - 27*a^2*d)^2))^(1/3)) - (1 + 1i*sqrt(3))*(-2*b^3 + 9*a*b*c - 27*a^2*d + sqrt(4*(-b^2 + 3*a*c)^3 + (-2*b^3 + 9*a*b*c - 27*a^2*d)^2))^(1/3)/(6*2^(1/3)*a);
    
    roots = [x1, x2, x3]; % Se almacenan en una misma variable
    
    fprintf("___Raíces___\nZ1 = %.3f\nZ2 = %.3f\nZ3 = %.3f", roots(1), roots(2), roots(3)),
end
