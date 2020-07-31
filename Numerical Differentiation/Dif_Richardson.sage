##################################################################################################

#       DIFERENCIACIÓN NUMÉRICA CON RICHARDSON
#
#	Ramos Guerrero Luis
#	Métodos Numéricos 2
#	Lic. en Matemáticas Aplicadas y Computación, UNAM

##################################################################################################

def main():

	print("\n\t\t  - D I F E R E N CI A C I Ó N  C O N  R I C H A R D S O N -")
	print("\n\n\t [  D A T O S  ]")
	
	f(x) = eval(input('\n\t f(x): '))
	print("\n\t Indica k para N_k:")
	N_K = int( input("\n\t ►  ") )
	print("\n\t Valor de h:")
	h = float( input("\n\t ►  ") )
	print("\n\t Valor de x0:")
	x0 = float( input("\n\t ►  ") )

	N = richardson( N_K, x0, h, f ) 

	print("\n\n\t [  R E S U L T A D O S  ]")
	print("\n\t ■  Matriz:")
	for j in range ( N_K ):
		print ("\n\t    ", N[j][:])
	print ("\n\t ■  f'(x) aprox:  ", N[0][N_K-1])

	g(x) = diff(f,x)
	
	print ("\n\t ■  Error:  ", abs( g(x0) - N[0][N_K-1] ).n(30))
	print ("\n\n\t ■  f'(x) real:  ", g(x0).n(30))



# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def richardson( N_K, x0, h, f ):

	N = [[0 for x in range( N_K )] for y in range( N_K )]
	for k in range ( N_K ):
		for j in range ( N_K ):
			if k == 0: 
				N[j][k] = dif_3pCentral( x0, h, f )
				h/=2;
			else:
				N[j][k] = N[j+1][k-1] + ( (N[j+1][k-1] - N[j][k-1]) / (4**(k)-1) )
		N_K-=1

	return N


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def dif_3pCentral( x0, h, f ):
	return (f(x0+h) - f(x0-h)) / (2*h)


	
if __name__ == '__main__':
    import sys
    sys.exit( main() )
