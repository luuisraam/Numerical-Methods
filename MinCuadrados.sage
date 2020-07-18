##################################################################################################

#       MÍNIMOS CUADRADOS
#
#	Ramos Guerrero Luis
#	Métodos Numéricos 2

##################################################################################################




# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def main():
	'''
	[Función]
	#	Arbol de llamadas a funciones:
	#
	#		main()
	#			MinCuadGetFunction()
	#				MinCuadGetCoeff()
	#					getCoeffs2x2()
	#					getListEcuations()
	#			MinCuadGetError()
	#
	#	name: main
	'''
	print("\n\t\t  - M É T O D O    D E    M Í N I M O S    C U A D R A D O S -")
	print("\n\n\t [  D A T O S  ]")

	print("\n\t Puntos a interpolar e.g. (x1,y1),(x2,y2),...,(xn,yn):")
	points = [ x for x in eval( input("\n\t ►  ") ) ]

	print("\n\t Selecciona el tipo de funcion buscada:")
	print("\t   [1] P(x) = anx^n + ... + a2x^2 + a1x + a0")
	print("\t   [2] y = be^ax")
	print("\t   [3] y = bx^a")
	option = int( input("\n\t ►  ") )

	#degree negativo corresponde a las funciones exponenciales
	if option == 1:
		print("\n\t Grado del polinomio deseado: ")
		degree = int( input("\n\t ►  ") )
		
	elif option == 2:
		degree = -1
		
	elif option == 3:
		degree = -2
		
	else: 
	    print("\n\t [!]Error: Opcion no existente.")
	    return

	print("\n\n\n\t [  R E S U L T A D O S  ]")
		
	function = MinCuadGetFunction( points, degree )
	print ("\n\t ■  Funcion: \n\n\t    ", function)
	print ("\n\t ■  Error: ", round( MinCuadGetError( points, function ), 8) )



# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def MinCuadGetFunction( points, degree ):
	'''
	[Función]
	#	Retorna la funcion interpolada.
	#	name: MinCuadGetFunction
	#  	@param points, degree
	#  	@return function
	'''
	C = MinCuadGetCoeff( points, degree )

	# Se genera las funciones con los coeficientes, son simbólicas.
	if degree >= 1:
		function = round( C[0], 5)
		function += sum(round( C[k], 5)*x^k for k in range ( 1, degree+1 ))

	elif degree == -1:
		function = round( exp(C[0]), 5 )*e^(round( C[1], 5)*x)
		
	elif degree == -2:
		function = round( exp(C[0]), 5 )*x^(round( C[1], 5 ) )
		
	return function



# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def MinCuadGetCoeff( points, degree ):
	'''
	[Función]
	#	Regresa una lista con los coeficientes de las funciones de mínimos cuadrados dados.
	#	name: MinCuadGetCoefs
	#  	@param points, degree
	#  	@return Coefs
	'''
	n = degree + 1
	m = len(points)
	X, Y = zip(*points)
		
	Coefs = []
	Resp = []
		
	# Se deja esta condición, ya que resolver el sist. de ec. de 2x2 con determinantes es más
	# rápido que el algoritmo que utiliza SAGE con solve
	if degree == 1:
		Coefs = getCoeffs2x2( X, Y, m)

	elif degree >= 2:
		list_ecuation, a = getListEcuations( X, Y, m, n )
		Resp = solve( list_ecuation, a, solution_dict=True)
		# Resp es de tipo simbólico y no existe un cast a real, un ejemplo para usar aproximaciones
		# numericas es retornar un dicionario. 
		# https://doc.sagemath.org/pdf/es/tutorial/SageTutorial.pdf pág 14
		Coefs += [Resp[0][a[j]].n(10) for j in range ( n )]

	# La forma exponencial genera un sistema de 2x2 cambiando Y por sus logaritmos
	elif degree == -1:
		list_Y = list( map( log, Y ) )
		Coefs = getCoeffs2x2( X, list_Y, m )
		
	elif degree == -2:
		list_X = list( map( log, X ) )
		list_Y = list( map( log, Y ) )
		Coefs = getCoeffs2x2( list_X, list_Y, m )

	return Coefs



# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def getCoeffs2x2( X, Y, m ):
	'''
	[Función]
	#	Resuelve un sistema de ec. de 2x2 por determinantes.
	#	name: getCoeffs2x2
	#  	@param X, Y, m
	#  	@return a0, a1
	'''
	SUM_X    = sum( X[i] 		for i in range( m ) )
	SUM_Y    = sum( Y[i] 		for i in range( m ) )
	SUM_XY   = sum( X[i]*Y[i] 	for i in range( m ) )
	SUM_XTO2 = sum( X[i]^2 		for i in range( m ) )

	print("\n\t ■  Sistema de ecuaciones: \n")
	print("\t    " + str(round( m,5 )) + "*a0 + " + str( round( SUM_X,5 ) ) + "*a1 = " + str( round( SUM_Y, 5) ))
	print("\t    " + str(round( SUM_X, 5)) + "*a0 + " + str( round( SUM_XTO2, 5) ) + "*a1 = " + str( round( SUM_XY, 5) ))

	a0 = (SUM_XTO2*SUM_Y - SUM_XY*SUM_X) / (m*SUM_XTO2 - SUM_X^2 )
	a1 = (m*SUM_XY - SUM_X*SUM_Y) / (m*SUM_XTO2 - SUM_X^2)

	return a0, a1



# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def getListEcuations( X, Y, m, n ):
	'''
	[Función]
	#	Retorna las ecuaciones del sistema a resolver. El algoritmo para generar el sistema se
	#	obtuvo de Burden, Douglas, Análisis Numérico pág 489
	#	name: getListEcuations
	#  	@param X, Y, m, n
	#  	@return list_ecuation, a
	'''
	a = SR.var('a', n )
	list_ecuation = []
	SUMAS_X = []
	SUMAS_Y = []
	SUMAS = []
		
	for j in range( n ):
		for k in range( n ):
			SUMAS_X += [round( sum( X[i]^(k+j) for i in range( m ) ), 4 )]
		SUMAS_Y += [round( sum( Y[i]*(X[i]^j) for i in range( m ) ), 4 )]
		SUMAS += [SUMAS_X]
		SUMAS_X = []
		
	for j in range ( n ):
		ecuation = sum(SUMAS[j][k]*a[k] for k in range( n ))
		# SUMAS_Y[j] se resta de la ecuación, porque se traslado al otro lado del igual
		# se intentó con ecuation == SUMAS_Y[j] sin éxito
		ecuation = ecuation - SUMAS_Y[j]
		list_ecuation.append(ecuation)

	print("\n\t ■  Sistema de ecuaciones: \n")
	for elem in list_ecuation:
		print ("\t    " + str(elem) + " = 0 ")
			
	return list_ecuation, a

	

# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def MinCuadGetError( points, function_interp ):
	'''
	[Función]
	#	Calcula el error de interpolación
	#	name: MinCuadGetError
	#  	@param points, function_interp
	#  	@return round( sum( (Y[i] - F(X[i]))^2 for i in range( m ) ), 7 )
	'''
	m = len(points)
	X, Y = zip( *points )
	# Esta asignación evita una DeprecatedWarning que jamás queda solucionado ni obsoleto
	# pide utilizar una funcion con los paréntesis f(x) en vez de f solamente
	F(x) = function_interp
	
	return sum( (Y[i] - F(X[i]))^2 for i in range( m ) )




if __name__ == '__main__':
	import sys
	sys.exit(main())
