/*
 * Luis Ramos
 * luuisraam@gmail.com
 * Estudiante de Matemáticas Aplicadas y Computación, UNAM
 * 2019
 *
 * 
 *
 * LEEME!!!!
 * 
 *                          MÉTODO DE NEWTON
 * 
 * Objetivo:
 *
 * Crear un programa  que mediante el método de Newton encuentre o aproxime algún cero de la función
 * en cuestión.
 *
 * 
 * Proceso general:
 *
 * Se establece un límite máximo de  100 iteraciones, se solicita al usuario ingresar en decimal (no
 * porcentaje) la tolerancia o precisión deseada,  posteriormente  se le solicita escribir el  valor
 * inicial para las iteraciones del método y se emitirá un resultado.
 *
 * 
 * Consideraciones:
 *
 * Por el momento la funcion a utilizar es estática,  por lo que, para calcular un cero de cualquier
 * otra función será necesario modificar la función f del código y la derivada f_2.
 *
 *      Ejemplo:
 * 
 *      Notación:   f(x)=x³-x-1     Código:     pow(x,3)-x-1
 *
 * 
 * Cambios a futuro:
 *
 * Se intentará migrar este código a Python para permitir el ingreso simbólico de la expresión.
 * 
 */


#include <stdio.h>
#include <stdbool.h>
#include <math.h>

#define EULER           2.718281
#define ITERATION_MAX   100

// > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
double f( double x );       // Función
double f_2( double x );     // Derivada
// < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < 

void reg_tolerance( double* );
void reg_initial( double* );
bool is_root( double, double(*)() );
double newton( double, double(*)(), double(*)() );
void tabulation( double, double, double(*)(), double(*)() );
void print_line();

int main() {
	
    double 	tolerance, 
            initial,
            (*ptr_f)(double),
            (*ptr_f_2)(double);
            
    printf("\n\n\t\t ++ METODO DE NEWTON ++\n");

    /* Se actualiza el puntero a la funcion f y a su derivada, decidí dejarle los punteros porque
       en una versión anterior, se debía hacer el cálculo a más de una función y eran necesarios. */
    ptr_f = f; ptr_f_2 = f_2;
    
    printf("\n\n     Para f(x) = x³-x-1 \n\n");
    
    reg_tolerance( &tolerance );
    reg_initial( &initial );	
    tabulation( initial, tolerance, ptr_f, ptr_f_2 );
    
    printf ("\n\n\t***\n\t***");

return 0;
	
}


/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Funcion matemática f(x)
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */ 		
double f( double x )
{
    return pow(x,3)-x-1;
}


/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Funcion matemática f_2(x) derivada de f
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */		
double f_2( double x )
{
    return 3*pow(x,2)-1;
}


/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Procedimiento que guardar el valor de la tolerancia para cada solución.
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */
void reg_tolerance( double* tolerance )
{
    printf("\t Indica la tolerancia en formato decimal: ");
    scanf("%lf", tolerance);	
}


/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Procedimiento que guardar el valor inicial para el método.
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */
void reg_initial( double* initial )
{
    printf("\t Indica el valor inicial: ");
    scanf("%lf", initial);	
}


/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Retorna la nueva iteracion del valor de x con la formula del metodo
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */
double newton( double x_n, double(*ptr_f)(), double(*ptr_f_2)() )
{
    return x_n - (ptr_f(x_n) / ptr_f_2(x_n));
}

/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Indica si el valor de x es la raíz de la funcion.
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */
bool is_root( double x, double(*ptr_f)() )
{
    if (ptr_f(x) == 0)
        return true;
    else
        return false;
}

/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >-
 * Este procedimiento realiza la impresión de todas las tabulaciones del metodo.
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */
void tabulation ( double initial, double tolerance, double(*ptr_f)(), double(*ptr_f_2)() )
{
    double	relative_e = 0.0,
            previous_initial;
    
    printf("\n\t Limite de iteraciones: %d", ITERATION_MAX);
    printf("\t Tolarencia: %lf", tolerance);
    print_line();
    printf("\n\t [i] \t x_i \t\t f(x_1) \t f\'(x_i) \t ER");
    print_line();
    
    /* Se genera la primer iteración, esta debe estar fuera del ciclo, de caso contrario
     * tendría errores con el cálculo del error relativo */
    printf ("\n\t [1] \t %5lf \t %.9lf \t %.9lf \t %.9lf", initial, ptr_f(initial), ptr_f_2(initial), relative_e);
    
    int i = 2;
    do 
    {
        previous_initial = initial;
        initial = newton( initial, ptr_f, ptr_f_2 );
        relative_e = fabs( (initial-previous_initial)/initial );
        printf ("\n\t [%d] \t %5.9lf \t %.9lf \t %.9lf \t %.9lf", i, initial, ptr_f(initial), ptr_f_2(initial), relative_e);

        if (is_root( initial, ptr_f ))
        {
            print_line();
            printf ("\n\t [] La raíz es %lf", initial);
            break;
        }
        i++;
        
    } while(i <= ITERATION_MAX && relative_e > tolerance);
    
    print_line();

    if (!is_root( initial, ptr_f ))
    {
        printf("\n\t [] La raíz aproximada es: %.9lf", initial);
        print_line();
    }

}

/* > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >
 * Imprime una línea.
 * < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < < */
void print_line()
{
    printf("\n      -------------------------------------------------------------------------");
}

