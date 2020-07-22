%% Comandos iniciales 
% Para reiniciar variables y cerrar cualquier programa que aún se esté
% corriendo.

clear all;
close all;
clc;

%% Carga de datos
% Se asignan variables a los datos obtenidos durante la práctica de
% laboratorio.

load FuerzaLisa.dat;
FuerzaL = FuerzaLisa;

load ElongacionLisa.dat;
ElongacionL = ElongacionLisa;

load FuerzaCorrugada.dat;
FuerzaC = FuerzaCorrugada;

load ElongacionCorrugada.dat;
ElongacionC = ElongacionCorrugada;

%% Definición de variables
% Se definen los valores iniciales y finales de la probeta, así como
% conversiones de unidades.

% Materiales a comparar:
HierroGrisG1800_20 = 66e9;
HierroGrisG1800_30 = 97e9;

% Probeta Lisa
LIL = 0.1532; % Longitud inicial lisa
DIL = 0.00952; % Diámetro inicial lisa
AIL = pi * ((DIL/2)^2); % Área inicial lisa

LFL = 0.1845; % Longitud final lisa
DFL = 0.00568; % Diámetro final lisa
AFL = pi * ((DFL/2)^2); % Área final lisa


%Probeta corrugada
LIC = 0.1770; % Longitud inicial corrugada
DIC = 0.01043; % Diámetro inicial corrugada
AIC = pi * ((DIC/2)^2); % Área inicial corrugada

LFC = 0.2025; % Longitud final corrugada
DFC = 0.00642; % Diámetro final corrugada
AFC = pi * ((DFC/2)^2); % Área final corrugada

%% Obtención de las varaibles de esfuerzo y deformación 
% Ya que las variables dadas son fuerza y elongación, estas tienen que ser
% modificadas o transformadas en esfuerzo y deformación respectivamente,
% para así realmente poder generalizar el comportamiento de un material.

EsfuerzoL = FuerzaL./AIL; % Fuerza entre área
DeformacionL = ElongacionL./(LIL*1000); % Elongación o diferencial de longitud entre longitud inicial

EsfuerzoC = FuerzaC./AIC; % Fuerza entre área
DeformacionC = ElongacionC./(LIC*1000); % Elongación o diferencial de longitud entre longitud inicial

%% Gráficas de Esfuerzo-Deformación
% Ya que se tienen variables que pueden generalizar el comportamiento de un
% material, estas se van a graficar para determinar el comportamiento del
% material descrito

figure("name", "Diagramas de Esfuerzo-Deformación")
subplot (4,2,1);
plot (DeformacionL, EsfuerzoL);
title ("Probeta Lisa");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
subplot (4,2,2);
plot (DeformacionC, EsfuerzoC);
title ("Probeta Corrugada");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;

%% Sección Elástica o Lineal:
% Para esta parte se van a filtrar los datos hasta donde se considere que
% sigue habiendo un comportamiento lineal, posteriormente se hará la
% reconstrucción de las demás áreas.

datosfiltradosL = eliminacion_de_ruido (DeformacionL, EsfuerzoL);
YoungL = lin (datosfiltradosL(:,1)', datosfiltradosL(:,2)');

datosfiltradosC = eliminacion_de_ruido (DeformacionC, EsfuerzoC);
YoungC = lin (datosfiltradosC(:,1)', datosfiltradosC(:,2)');

j = linspace(min(datosfiltradosL(:,1)), max(datosfiltradosL(:,1)), 2);
k = linspace(min(datosfiltradosC(:,1)), max(datosfiltradosC(:,1)), 2);

subplot (4,2,3);
hold on
plot (datosfiltradosL(:,1), datosfiltradosL(:,2));
plot (j, (YoungL(2) * j) + YoungL(1)); 
title ("Probeta Lisa: Sección Elástica");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
hold off
subplot (4,2,4);
hold on
plot (datosfiltradosC(:,1), datosfiltradosC(:,2));
plot (k, (YoungC(2) * k) + YoungC(1)); 
title ("Probeta Corrugada: Sección elástica");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
hold off

%% Medición de error en la sección elástica:
% Se van a definir el rango para el comportamiento elástico, así como el
% error con respecto a los valores deseados.

errorlisa = abs((YoungL(2) - HierroGrisG1800_30)/ YoungL(2));
errorcorrugada = abs((YoungC(2) - HierroGrisG1800_20)/ YoungC(2));

%% Zona entre el límite de de elasticidad y el límite aparente de elasticidad/ límite de fluencia
% Esta zona es mencionada muy pocas veces por los libros de texto, pero 
% como su nombre lo dice es una zona donde el comportamiento ya no es 100%
% elástico y termina con el límite superior de fluencia 

zonaxL = ult_punto(datosfiltradosL, DeformacionL, EsfuerzoL);
zonaxC = ult_punto(datosfiltradosC, DeformacionC, EsfuerzoC);

partecuadL = filtrozona(zonaxL);
partecuadC = filtrozona(zonaxC);

realvaparenteL = cuad(partecuadL);
realvaparenteC = cuad(partecuadC);

qx = @(q) realvaparenteL(1)*(q^2)+realvaparenteL(2)*(q)+realvaparenteL(3);
wx = @(w) realvaparenteC(1)*(w^2)+realvaparenteC(2)*(w)+realvaparenteC(3);

subplot (4,2,5);
hold on
plot (partecuadL(:,1), partecuadL(:,2));
fplot (qx, [partecuadL(1,1) partecuadL(length(partecuadL),1)]); 
title ("Probeta Lisa: Sección elastico-plástica");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
hold off
subplot (4,2,6);
hold on
plot (partecuadC(:,1), partecuadC(:,2));
fplot (wx, [partecuadC(1,1) partecuadC(length(partecuadC),1)]);
title ("Probeta Corrugada: Sección elastico-plástica");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
hold off

%% Meseta de fluencia:
% En esta parte, el material tiende a oscilar, ya que internamente las
% fuerzas y vibraciones necesitan estabilizarse, usualmente, los diagramas
% de esfuerzo-deformación tienen a graficar únicamente los límites superior
% e inferior

zonaxL = ult_punto(partecuadL, DeformacionL, EsfuerzoL);
zonaxC = ult_punto(partecuadC, DeformacionC, EsfuerzoC);

zonamesetaL = filtromeseta(zonaxL);
zonamesetaC = filtromeseta(zonaxC);

mesetasuaveL = suave(zonamesetaL);
mesetasuaveC = suave(zonamesetaC);

%% Endurecimiento por deformación:
% En esta sección se eliminará el ruido

zonaxL = ult_punto(zonamesetaL, DeformacionL, EsfuerzoL);
zonaxC = ult_punto(zonamesetaC, DeformacionC, EsfuerzoC);

endudefL = endu_def(zonaxL);
endudefC = endu_def(zonaxC);

%% Estricción de fluencia
% En esta sección se eliminará el ruido 

zonaxL = ult_punto(endudefL, DeformacionL, EsfuerzoL);
zonaxC = ult_punto(endudefC, DeformacionC, EsfuerzoC);

estflueL = est_flue(zonaxL);
estflueC = est_flue(zonaxC);

%% Impresión de resultados:
% Se imprimen todos los resultados obtenidos
subplot (4,2,7);
hold on
plot (j, (YoungL(2) * j) + YoungL(1)); 
fplot (qx, [partecuadL(1,1) partecuadL(length(partecuadL),1)]); 
plot(mesetasuaveL(:,1), mesetasuaveL(:,2));
plot(endudefL(:,1), endudefL(:,2));
plot(estflueL(:,1), estflueL(:,2));
title ("Probeta Lisa: Reinventada");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
hold off
subplot (4,2,8);
hold on
plot (k, (YoungC(2) * k) + YoungC(1)); 
fplot (wx, [partecuadC(1,1) partecuadC(length(partecuadC),1)]);
plot(mesetasuaveC(:,1), mesetasuaveC(:,2));
plot(endudefC(:,1), endudefC(:,2));
plot(estflueC(:,1), estflueC(:,2));
title ("Probeta Corrugada: Reinventada");
xlabel ("Deformación Unitaria");
ylabel ("Esfuerzo (Pa)");
grid on;
hold off

fprintf("<strong>Análisis de los datos dados: </strong> \n\n");

fprintf("<strong>Sección elástica: </strong> \n");

fprintf(" Los datos del modelo lineal de la sección elástica de la probeta lisa son:\n  m = %2.4f GPa\n  b = %2.4f GPa\n  R²= %.4f\n  error relativo = %.4f\n\n" +...
    " Los datos del modelo lineal de la sección elástica de la probeta corrugada son:\n  m = %2.4f GPa\n  b = %2.4f GPa\n  R²= %.4f\n  error relativo = %.4f\n\n",...
    (YoungL(2)/1e9), (YoungL(1)/1e9), YoungL(3), errorlisa,(YoungC(2)/1e9), (YoungC(1)/1e9), YoungC(3), errorcorrugada);

fprintf("<strong>Sección elástico-plástica: </strong> \n");

fprintf(" Los datos del modelo cuadrático de la sección elastico-plástica de la probeta lisa son:\n  Coeficientes:\n   a = %.4f TPa\n   b = %.4f GPa\n   c = %.4f MPa\n  R² = %.4f\n\n"+...
   " Los datos del modelo cuadrático de la sección elastico-plástica de la probeta corrugada son:\n  Coeficientes:\n   a = %.4f TPa\n   b = %.4f GPa\n   c = %.4f MPa\n  R² = %.4f\n\n",...
   realvaparenteL(1)/1e12,realvaparenteL(2)/1e9,realvaparenteL(3)/1e6,realvaparenteL(4),realvaparenteC(1)/1e12,realvaparenteC(2)/1e9,realvaparenteC(3)/1e6,realvaparenteC(4));

fprintf("<strong>Meseta de fluencia: </strong> \n");


%% Funciones de apoyo:

% Función para eliminar el ruido de la sección lineal
function datosfiltrados = eliminacion_de_ruido (deformacion, esfuerzo)

n = numel(deformacion);
pendiente = [];
datosfiltrados = [];
j = 0;

for i = 1:n
    
    if deformacion(i) <= .002
        
        m = (esfuerzo(i+1) - esfuerzo(i))/ (deformacion(i+1) - deformacion(i));
        
        pendiente(i) = m;
        
        p = i;
        datosfiltrados(i,1) = deformacion(i);
        datosfiltrados(i,2) = esfuerzo(i);
        
    end
    
    if deformacion(i) > .002
        
        m = (esfuerzo(i+1,1) - esfuerzo(i,1))/ (deformacion(i+1,1) - deformacion(i,1));
        
        prom = mean(pendiente); 
        
        if abs((m-prom)/m) <= .65
            
            p = p+1;
            pendiente(p) = m;
            datosfiltrados(p,1) = deformacion(i);
            datosfiltrados(p,2) = esfuerzo(i);
            j = 0;
            
        else
            
            j = j+1;
            
        end
        
        if j == 50
            
           break
            
        end
        
    end
    
end

end

% Función para obtener la regresión lineal
function resultado = lin(x,y)
    
    lineo = [ones(length(x),1) x']\y';
    St = sum((y - mean(y)).^2);
    Sr = sum((((lineo(2)*x)+lineo(1)) - y).^2);
    r2 = (St- Sr)/St;
    resultado = [lineo(1) lineo(2) r2];
        
end

% Función que corta la lista de datos desde el último punto en el que se
% quedó
function puntosfaltantes = ult_punto (filtrados, x, y)
    m = size(filtrados);
    puntosfaltantes=[];
    t = 0;
    
    for i = 1:numel(x)
        p=i;
        if filtrados(m(1),1) == x(i,1)
            break
        end
    end
    
    for j = p:numel(x)
        t = t+1;
        puntosfaltantes(t,1)= x(j);
        puntosfaltantes(t,2)= y(j);
    end
    
end

% Filtrar datos entre el límite real y el aparente
function zonaestudio =   filtrozona(zona)

    m = size(zona);
    j = 0;
    p=1;

    for i = 2: m(1)
        
        if zona(i,2)> zona((i-1),2)
        
            zonaestudio(p,1) = zona(i,1);
            zonaestudio(p,2) = zona(i,2);
            p = p+1;
            j = 0;
            
        end
        j = j+1;
        if j == 3
            
            break
            
        end
    end

end

% Función para realizar una reegresión cuadrática junto con R²
function modelocuad = cuad(zona)

    x = zona(:,1);
    y = zona(:,2);
    coeficientes = polyfit( x, y, 2);
    St = sum((y - mean(y)).^2);
    yp = polyval(coeficientes,x);
    Sr = sum((yp - y).^2);
    r2 = (St- Sr)/St;
    modelocuad = [coeficientes(1) coeficientes(2) coeficientes(3) r2];

end

% Función para filtrar el rango donde está la meseta de fluencia
function zonameseta = filtromeseta(zona)
    f = 0;
    zonameseta = [];

    for i = 1:length(zona)
        
        if zona(i+1,2) > zona(i,2)
            
            f= f+1;
            
        end
        
        if f == 100
            
            break
            
        end
        
        zonameseta (i,1) = zona(i,1);
        zonameseta (i,2) = zona(i,2);
        
    end
    
end

% Función para suavizar la meseta de fluencia
function meseta = suave(zona)

init = zona(1,:);
min = [];
max = [];
min(2) = zona(1,2);
max(2) = zona(1,2);
meseta = [];
p = 1;

 for i = 1:length(zona)
     
     if zona(i,2) > max
         
         max(1) = zona(i,1);
         max(2) = zona(i,2);
     
     end
     
     if zona(i,2) < min
         
         min(1) = zona(i,1);
         min(2) = zona(i,2);
     
     end
     
 end
 
 if min(1) <= max(1)
    
     max = init;
     
 end
 
 for i = 1:(length(zona)-1)
     
     if zona(i,1) <= max(1)
         
         if zona(i,2) <= zona(i+1,2)
             
             meseta (p,1) = zona (i,1);
             meseta (p,2) = zona (i,2);
             p = p + 1;
         
         end
     end

     if (zona(i,1) >= max(1)) && (zona(i,1) <= min(1))
         
         if zona(i,2) >= zona(i+1,2)
             
             meseta (p,1) = zona (i,1);
             meseta (p,2) = zona (i,2);
             p = p+1;
         
         end
     end

     if (zona(i,1) >= min(1))
         
         if zona(i,2) <= zona(i+1,2)
             
             meseta (p,1) = zona (i,1);
             meseta (p,2) = zona (i,2);
             p = p+1;
         
         end
     end
     
 end
 
end

% Función para eliminar ruido en subida
function  endurecimiento = endu_def(zona)

    p =1;
    min = zona(1,2);
    endurecimiento = [];
    
    for i = 1:length(zona)
        
        if zona(i,2) > min
            
            endurecimiento (p,1) = zona(i,1);
            endurecimiento (p,2) = zona(i,2);
            p = p+1;
            min = zona(i,2);
            
        end
        
    end

end

% Función para eliminar ruido en bajada
function  est = est_flue(zona)

    p =1;
    max = zona(1,2);
    est = [];
    
    for i = 1:length(zona)
        
        if zona(i,2) < max
            
            est (p,1) = zona(i,1);
            est (p,2) = zona(i,2);
            p = p+1;
            max = zona(i,2);
            
        end
        
    end

end