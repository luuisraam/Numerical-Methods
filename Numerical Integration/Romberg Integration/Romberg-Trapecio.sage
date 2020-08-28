

##################################################################################################

#       INTEGRACIÓN COMPUESTA
#
#	Ramos Guerrero Luis
#	Métodos Numéricos 2
#	Lic. en Matemáticas Aplicadas y Computación, UNAM

##################################################################################################


def main():
	

	function = sin(x)
	a = 0
	b = pi
	n = 6

	R = []
	
	for k in range (1, n+1):
		if k == 1:
			R = [Rkj( 1, function, a, b, k )]
		else:
			R += [Rkj( R[k-2], function, a, b, k )]

	print ("\n\tFuncion: " + str(function) + " a = " + str(a) + " b = "+ str(b) + " n = " + str(n))
	print ("\n\tCOLUMNA R[k,1]\n")

	for elem in R:
		print ("\t",elem)
	


def Rkj (Rk_1, function, a, b, k):
	'''
	'''
	f(x) = function
	h = (b-a)/(2**(k-1))
	
	if k == 1:
		return ((h/2)*(f(a)+f(b))).n(30)
	else:
		hk_1 = (b-a)/(2**(k-2))
		return ((1/2)*(Rk_1 + hk_1 * sum( f(a+(2*i-1)*h) for i in range( 1, 2**(k-2)+1 ) )) ).n(30)



if __name__ == '__main__':
    import sys
    sys.exit( main() )
