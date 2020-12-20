##################################################################################################

#       INTEGRACIÓN COMPUESTA
#
#	Ramos Guerrero Luis
#	Métodos Numéricos 2
#	Lic. en Matemáticas Aplicadas y Computación, UNAM

##################################################################################################



def main():

    # Datos Entrada
    function = sin(x)
    a = 0
    b = pi
    n = 20

    print("\n\t\t  - I N T E G R A C I O N   C O M P U E S T A -")


    print("\n\n  Para la funcion " + str( function ) + ", a = " + str( a ) + ", b = " + str( b ) + ", n = " + str( n ))
    print("\n\t [SIMPSON]")
    print("\n\t\t", simpsons_rule(function, a, b, n))
    print("\n\t [PTO MEDIO]")
    print("\n\t\t", midpoint_rule(function, a, b, n-2))
    print("\n\t [TRAPECIO]")
    print("\n\t\t", trapezoid_rule(function, a, b, n))


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def simpsons_rule( function, a, b, n ):
    f(x) = function
    h = (b-a)/n
    n2 = int( n/2 )
return ((h/3)*(f(a) + 2*sum(f(a+(2*j*h)) for j in range( 1, n2-1+1 )) + 4*sum(f(a+((2*j-1)*h)) for j in range( 1,n2+1 )) + f(b) )).n(30)


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def midpoint_rule( function, a, b, n ):
    f(x) = function
    h = (b-a)/(n+2)
    n2 = int( n/2 )
    return (2*h*sum(f(a+(2*j+1)*h) for j in range( n2+1 ))).n(30)
    

# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def trapezoid_rule( function, a, b, n ):
    f(x) = function
    h = (b-a)/n
    n2 = int( n/2 )
    return ((h/2)*(f(a) + 2*sum(f(a+(j*h)) for j in range( 1, n-1+1 ))  + f(b) )).n(30)



# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
if __name__ == '__main__':
    import sys
    sys.exit( main() )
    
