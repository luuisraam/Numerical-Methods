##################################################################################################

#       CÁLCULO DEL ERROR EN DIFERENCIACIÓN NUMÉRICA
#
#	Ramos Guerrero Luis
#	Métodos Numéricos 2
#	Lic. en Matemáticas Aplicadas y Computación, UNAM

##################################################################################################


def main():

	list_ecuations = [2/(x-4), x**2*(log(x)), x**2*e**-x, 2*x/(x**2-4), 2/(x**2-4), x*sin(x), e**(3*x)*sin(2*x)]
	x0 = [0.25, 1.25, 0.5, 1.3, 0.175, 0.392699082, 0.392699082]
	h = [0.5, 0.5, 1,0.6, 0.35, 0.785398163, 0.785398163]

	i=0
	for elem in list_ecuations:
		print(error(elem, x0[i], h[i]))
		i+=1

def error ( l, x0, h ):
	# Esta asignación evita una DeprecatedWarning que jamás queda solucionado ni obsoleto.
	f(x)=l
	g1=diff( f, 2 )
	g2=diff( f, 4 )
	
	return abs( g2(x0)*((h/2)**5/90) )

	#abs( g1(x0)*(h**3/12) ), abs( g2(x0)*((h/2)**5/90) ), abs( g1(x0)*((h/2)**3/3) )


if __name__ == '__main__':
    import sys
    sys.exit( main() )
