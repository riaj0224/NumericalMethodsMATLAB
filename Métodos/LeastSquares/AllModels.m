%% Esta es una función que selecciona el mejor modelo para los datos
dados
% Equipo2: HarryPotter
%% Algoritmo
function resultados = mejor_modelo(archivo, verbose) % Se declaran las
entradas y salidas
datos = readmatrix(archivo); % Se leen los archivos con los datos
coedet = 0; % Se declara el coeficiente de determinación inicial
model = []; % Se declara variable con resultados
ar2 = []; % Almacenan coeficientes de determinación
X = (datos(:,1))'; % Se importan datos
Y = (datos(:, 2))'; % Se importan datos
for i = 1:3 % Analizar cada modelo
 switch i % Switch case para cada caso
 %{
 case 1
 c = lin(X,Y);
 name = "Linear";
 ar2(1) = c(3);
 %}
 case 1 % Modelo exponencial
 c = lin(X,log(Y));
 name = "Exponential";
 ar2(2) = c(3);
3
 case 2 % Modelo de potencia
 c = lin(log(X),log(Y));
 name = "Power";
 ar2(3) = c(3);
 case 3 % Modelo de crecimiento
 c = lin(1./X,1./Y);
 name = "Growth-rate";
 ar2(4) = c(3);
 end
 if c(3) > coedet % Condicional para ver qué modelo es mejor y
guardar datos
 model = [c(1) c(2) c(3)];
 mod = name;
 coedet = c(3);
 end
end
switch mod % Generar la función del modelo
 case "Linear"
 yp = @(xp) ((model(2)*xp)+model(1));
 case "Exponential"
 yp = @(xp) exp(((model(2)*xp)+model(1)));
 case "Power"
 yp = @(xp) ((xp.^model(2))*(exp(model(1))));
 case "Growth-rate"
 yp = @(xp) ((1/model(1))*(xp/(xp+(model(2)/model(1)))));
end
4
funct = func2str(yp);
if verbose == true % Mostrar todas las gráficas
 figure("Name", "Datos con Modelo de Regresión");
 hold on;
 scatter(X,Y);
 fplot(yp, [min(X) max(X)])
 title(mod + " Model");
 ylabel("Tiempo (s)");
 xlabel("Distancia (m)");
 grid on;
 hold off;
end
%% Preguntas de los problemas
fprintf("R² de cada modelo:\n Linear: %f\n Exponential: %f\n Power:
%f\n Growth-rate: %f\n", ar2);
fprintf("Model "+ mod +": " + funct + "\n");
recordmilla = 223.23;
yp_milla = yp(1609.34);
errorabs = recordmilla - yp_milla;
errorrelav = abs(errorabs/recordmilla);
fprintf("El error absoluto del modelo con el record actual en carrera
de una milla es de:\n Error Absoluto: %f\n Error Relativo: %f\n",
errorabs, errorrelav)
tiempo8k = yp(8000);
fprintf("El tiempo proyectado en los 8,000 metros planos es de: %f
segundos\n", tiempo8k);
gp = matlabFunction(finverse(sym(yp)));
5
distancia_max_hr = gp(3600);
fprintf("La distancia máxima que se puede recorrer en 1 hora es de: %f
metros\n", distancia_max_hr);
figure("Name", "Velocidad promedio vs Distancia con los datos dados");
plot(X,(X./Y));
title("Velocidad vs Distancia");
ylabel("Velocidad (m/s)");
xlabel("Distancia (m)");
grid on;
resultados = model;
%% Función de ayuda para obtener la función lineal
 function resultado = lin(x,y)
 lineo = [ones(length(x),1) x']\y';
 St = sum((y - mean(y)).^2);
 Sr = sum((((lineo(2)*x)+lineo(1)) - y).^2);
 r2 = (St- Sr)/St;
 resultado = [lineo(1) lineo(2) r2];
 end
end
