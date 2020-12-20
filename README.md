# Métodos Numéricos [Numerical Methods]

## Acerca de [About]

**Algunos Métodos Numéricos escritos en C y en SageMath (un CAS libre de código abierto, basado en Python).**

**Some Numerical Methods written in C and SageMath (a free open-source CAS, Python based).**

## Clasificación de los Métodos [Classification of Numerical Methods]

- Raíces de la función [Root-Finding Methods]
  - Método de Newton-Raphson [Newton-Raphson Method] - newton_raphson_method.c
  - Método de Bisección [Bisection Method] - bisection_method.c
  
- Solución de Sistemas de Ecuaciones No Lineales
  - Ḿétodo de Punto Fijo
  - Método de Newton
  - Método de Gauss Seidel

- Interpolación [Interpolation]
  - Método de Mínimos Cuadrados [Least Squares] - least_squares.sage
  
- Diferenciación Numérica [Numerical Differentiation]

- Integración Numérica [Numerical Integration]
  - Método de Integración Compuesta [Composite Numerical Integration] - composite_integration.sage
  - Método de Romberg [Romberg's Method] - romberg_method.sage

## Ejecución 🔧

Lenguaje C

```
gcc -Wall -o ejemplo ejemplo.c -lm
./ejemplo
```

SageMath
```
sage ejemplo.sage
```

## Pruebas
_En proceso de redacción._

## Construido con

* [SageMath - Lenguaje](https://www.sagemath.org/)
* [C - Lenguaje](https://es.wikipedia.org/wiki/Dennis_Ritchie)
* [Geany - IDE](https://www.geany.org/)

## Versión 📌
* V1.1 - En construcción 

## Autores

* [luuisraam](https://github.com/luuisraam) - **Luis Ramos**

## Aportaciones

* [RuberDavid](https://github.com/RuberDavid)
