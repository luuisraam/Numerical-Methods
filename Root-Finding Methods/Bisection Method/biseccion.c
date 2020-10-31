/*
 * Luis Ramos
 * luuisraam@gmail.com
 * Estudiante de Matemáticas Aplicadas y Computación, UNAM
 *
 * 
 *
 * LEEME!!!!
 * 
 * 									Método de Bisección
 * 
 * Objetivo:
 *
 * Crear un programa que  mediante el método de  Bisección encuentre o aproxime las raices de 4 fun-
 * ciones.
 *
 * 
 * Proceso general:
 *
 * Se establece un límite máximo de  100 iteraciones, se solicita al usuario ingresar en decimal (no
 * porcentaje) la tolerancia o precisión,  posteriormente se le solicita escribir los intervalos, se
 * sugiere en pantalla  uno que ya cumple  con el teorema  de bolzano, sin embargo, el usuario podrá 
 * ingresar cualquier otro, una vez que se cumpla el teorema, se procedera a calcular el método.
 *
 * 
 * Consideraciones:
 *
 * Por el momento las funciones a utilizar son estáticas, por lo que, para usar cualquier  otra fun-
 * ción, será necesario modificar las funciones f, g, h, i del código.
 * Algunos ejemplos:
 * 
 *	Notación:	f(x)=x³-x-1					Código:		pow(x,3)-x-1
 *	Notación:	g(x)=-2x³-4x²+4x+4			Código:		((-2)*pow(x,3))-(4*pow(x,2))+(4*x)+4
 *	Notación:	h(x)=x-2^(-x) 1				Código:		x-pow(2,-x)
 *	Notación:	i(x)=e^x+2^(-x)+2cos(x)-6	Código:		pow(EULER,x)+pow(2,-x)+(2*cos(x))-6
 *
 * 
 * Cambios a futuro:
 *
 * Se intentará migrar este código a Python para permitir el ingreso simbólico de las expresiones.
 * 
 */
 

#include <stdio.h>
#include <stdbool.h>
#include <math.h>

#define EULER 2.718281
#define ITERATION_MAX 100

void	reg_tolerance(double*);
void 	reg_range(double*, double(*ptr_f)());
bool	is_root(double, double(*)());
bool 	bolzano(double*, double(*)());
double 	bisection_method(double*, double relative_e, double(*)());
double 	midpoint(double*);
void 	tabulation (double*, double*, double(*ptr_f)());
void 	print_line();

// Estas son las funciones matemáticas.
double 	f(double x);
double 	g(double x);
double 	h(double x);
double 	i(double x);


int main() {
	
	double 	x_[3], 
			tolerance,
			(*ptr_f)(double);
			
	printf("\n\n\t\t ++ METODO DE BISECCION ++\n");
	printf("\n     Nota: El numero max de iteraciones fue establecido en 100.\n");
		
	/* Se actualiza el puntero a la funcion f */
	ptr_f=f;
	printf("\n\n     Para f(x) = x³-x-1\n");
	reg_tolerance(&tolerance);
	printf("\t Escribe los valores para x_0 y x_1. Sugeridos (0, 2): ");
	reg_range(x_, ptr_f);
	tabulation(x_, &tolerance, ptr_f);
	printf ("\n\n\t***\n\t***\n\t***\n");
	
	/* Se actualiza el puntero a la funcion g */
	ptr_f=g;
	printf("\n     Para g(x) = -2x³-4x²+4x+4\n");
	reg_tolerance(&tolerance);
	printf("\t Escribe los valores para x_0 y x_1.Sugeridos (0, 2): ");
	reg_range(x_, ptr_f);
	tabulation(x_, &tolerance, ptr_f);
	printf ("\n\n\t***\n\t***\n\t***\n");
	
	/* Se actualiza el puntero a la funcion h */
	ptr_f=h;
	printf("\n     Para h(x) = x-2^(-x)\n");
	reg_tolerance(&tolerance);
	printf("\t Escribe los valores para x_0 y x_1. Sugeridos (0, 1): ");
	reg_range(x_, ptr_f);
	tabulation(x_, &tolerance, ptr_f);
	printf ("\n\n\t***\n\t***\n\t***\n");
	
	/* Se actualiza el puntero a la funcion i */
	ptr_f=i;
	printf("\n     Para i(x) = e^x+2^(-x)+2cos(x)-6\n");
	reg_tolerance(&tolerance);
	printf("\t Escribe los valores para x_0 y x_1. Sugeridos (1, 2): ");
	reg_range(x_, ptr_f);
	tabulation(x_, &tolerance, ptr_f);
		
	
return 0;
	
}




/*--------------------------------------------------------------------------------------------------
 * Funcion matemática f(x)
 * -----------------------------------------------------------------------------------------------*/		
double f(double x)
{
	return pow(x,3)-x-1;
}


/*--------------------------------------------------------------------------------------------------
 * Funcion matemática g(x)
 * -----------------------------------------------------------------------------------------------*/		
double g(double x)
{
	return ((-2)*pow(x,3))-(4*pow(x,2))+(4*x)+4;
}


/*--------------------------------------------------------------------------------------------------
 * Funcion matemática h(x)
 * -----------------------------------------------------------------------------------------------*/		
double h(double x)
{
	return x-pow(2,-x);
}


/*--------------------------------------------------------------------------------------------------
 * Funcion matemática i(x)
 * -----------------------------------------------------------------------------------------------*/		
double i(double x)
{
	return pow(EULER,x)+pow(2,-x)+(2*cos(x))-6;
}


/*--------------------------------------------------------------------------------------------------
 * Procedimiento que guardar el valor de la tolerancia para cada solución.
 * -----------------------------------------------------------------------------------------------*/
void reg_tolerance(double* tolerance)
{
	printf("\t Indica la tolerancia en formato decimal: ");
	scanf("%lf", tolerance);	
}


/*--------------------------------------------------------------------------------------------------
 * Procedimiento qu registra el rango que cumpla con el teorema de bolzano.
 * -----------------------------------------------------------------------------------------------*/
void reg_range(double* x_, double(*ptr_f)())
{
	do 
	{
		/* Es cierto que o x_[0] es raiz o x[1] es raíz o ambos lo son, por lo que los if 
		* no deben estar anidados */
		printf("\n\t [x_0]: "); 	scanf("%lf", &x_[0]);
		printf("\t [x_1]: "); 		scanf("%lf", &x_[1]);
		if (is_root(x_[0], ptr_f))
		{
			print_line();
			printf ("\n\t x_0 es raíz.");
			print_line();
		}
		if (is_root(x_[1], ptr_f))
		{	
			print_line();
			printf("\n\t x_1 es raíz.");
			print_line();
		}
	
		if (!bolzano(x_, ptr_f))
			printf ("\n\t *Las cotas no cumplen con el teorema de Bolzano.\n");
		else
		{
			printf("\n\t *Cotas validas, cumplen el teorema de bolzano.\n");
			print_line();
			break;
		}
		
	} while(true);
}

/*----------------------------------------------------------------------------------------
 * Indica si el valor de x es la raíz de la funcion.
 * -------------------------------------------------------------------------------------*/
bool is_root(double x, double(*ptr_f)())
{
	if (ptr_f(x) == 0)
		return true;
	else
		return false;
}


/*--------------------------------------------------------------------------------------------------
 * Esta función verifica el teorema de Bolzano de tal forma que se cumpla que:
 * root_a_a[0]<0 y a_root_a_a[1]>0 entonces (a_root_a_a[0]*a_root_a_a[1])<0
 * -----------------------------------------------------------------------------------------------*/
bool bolzano( double* x_, double(*ptr_f)() )
{
	double aux;
	if ( ( ptr_f(x_[0]) * ptr_f(x_[1]) ) < 0 )
	{
		/* Intercambia los valores para que el intervalo sea (x,y) / x<y) */
		if (x_[0] > x_[1])
		{
			aux=x_[0];
			x_[0]=x_[1];
			x_[1]=aux;
		}
		
		return true;
	}
	else
		return false;
}


/*--------------------------------------------------------------------------------------------------
 * Esta funcion actualiza los x_0, x_1 y el punto medio en cada iteración.
 * -----------------------------------------------------------------------------------------------*/		
double bisection_method( double* x_, double middle, double(*ptr_f)() ) 
{
	
	/* Como ptr_f(_x_[0])<0, si ptr_f(x_[0])*ptr_f(root_a) < 0
	 * aseguramos que la raiz existe y se cumple que x_[0]<raiz<root_a*/
	if ( ptr_f(x_[0])*ptr_f(middle) < 0)
	{
		// x_[0] = x_[0] se conserva
		x_[1] = middle;
	}
	/* Como ptr_f(_x_[0])<0, si ptr_f(x_[0])*ptr_f(root_a) > 0
	 * aseguramos que la raiz existe y se cumple que root_a<raiz<x_[1]*/
	else if (ptr_f(x_[0])*ptr_f(middle) > 0)
	{
		// x_[1] = x_[1] se conserva
		x_[0] = middle;
	}
	else
	{
		return middle;
	}

	return midpoint(x_);
}


/*--------------------------------------------------------------------------------------------------
 * Esta funcion retorna el punto medio entre dos puntos.
 * -----------------------------------------------------------------------------------------------*/
double 	midpoint(double* x_)
{
	return (x_[0]+x_[1]) / 2;
}


/*--------------------------------------------------------------------------------------------------
 * Este procedimiento realiza la impresión de todas las tabulaciones del metodo.
 * -----------------------------------------------------------------------------------------------*/
void tabulation (double* x_, double* tolerance, double(*ptr_f)() )
{
	double  middle, 
			previous_middle, 
			relative_e = 0.0;
	
	printf("\n\t Intervalo: (%lf, %lf)", x_[0], x_[1]);
	printf("\n\t Limite de iteraciones: %d", ITERATION_MAX);
	printf("\t Tolarencia: %lf", *tolerance);
	print_line();
	printf("\n\t [i] \t x_0 \t\t x_1 \t\t a_root \t ER");
	print_line();
	
	/* Se genera la primer iteración, esta debe estar fuera del ciclo, de caso contrario
	 * tendría errores con el cálculo del error relativo */
	middle=midpoint(x_);
	previous_middle=middle;
	printf ("\n\t [1] \t %5lf \t %.9lf \t %.9lf \t %.9lf", x_[0], x_[1], middle, relative_e);
	middle=bisection_method(x_, middle, ptr_f);
	
	int i = 2;
	do 
	{
		relative_e=fabs((middle-previous_middle)/middle);
		printf ("\n\t [%d] \t %5.9lf \t %.9lf \t %.9lf \t %.9lf", i, x_[0], x_[1], middle, relative_e);
		previous_middle=middle;
		middle=bisection_method(x_, middle, ptr_f);

		if (ptr_f(middle) == 0.0)
		{
			printf ("\n\t [] La raíz es %lf", middle);
			break;
		}
		i++;
		
	} while(i <= ITERATION_MAX && relative_e > *tolerance);
	
	print_line();

	if (ptr_f(middle) != 0.0)
	{
		printf("\n\t [] La raíz aproximada es: %.9lf", middle);
		print_line();
	}

}


/*--------------------------------------------------------------------------------------------------
 * Imprime una línea.
 * -----------------------------------------------------------------------------------------------*/
void print_line()
{
	printf("\n      -------------------------------------------------------------------------");
}
