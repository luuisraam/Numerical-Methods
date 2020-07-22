#   Código para la Tarea #2
#   Por Oscar David Domínguez Dávila 
#   
#   INSTRUCCIONES: 
#       abrir el interprete de sage
#       llamar este archivo con:
#                load( 'carpeta/CODIGO_TAREA2.sage' )
#           o   
#                attach( 'carpeta/CODIGO_TAREA2.sage' )



###############################################################

#       MÍNIMOS CUADRADOS

###############################################################
def MinCuad_Coefs( points, Grado=1 ):

	Coefs = []
	m = len(points)
	n = Grado+1
	X, Y = zip(*points)
	
	SUMAS_X = []
	SUMAS_Y = []
	SUMAS = []
	Resp = []
	
	if Grado==1:

		m = len(points)
		
		# zip(*) es la función inversa a zip(); te separa las tuplas
		X, Y = zip(*points)
		
		SUM_X    = sum( X[i] 		for i in range( m ) )
		SUM_Y    = sum( Y[i] 		for i in range( m ) )
		SUM_XY   = sum( X[i]*Y[i] 	for i in range( m ) )
		SUM_XTO2 = sum( X[i]^2 		for i in range( m ) )
		
		a0 = (SUM_XTO2*SUM_Y - SUM_XY*SUM_X) / (m*SUM_XTO2 - SUM_X^2 )
		a1 = (m*SUM_XY - SUM_X*SUM_Y) / (m*SUM_XTO2 - SUM_X^2)
		
		Coefs = [a0]
		Coefs += [a1];

	else: 
	
		for j in range ( n ):
			for k in range ( n ):
				SUMAS_X += [sum( X[i]^(k+j) for i in range( m ) )]
			SUMAS_Y += [sum( Y[i]*(X[i]^j) for i in range( m ) )]
			SUMAS += [SUMAS_X]
			SUMAS_X = []
			
		if Grado==2:
		
			a2, a1, a0 = var('a2, a1, a0')
			
			Resp = solve( [ SUMAS[0][0]*a0 + SUMAS[0][1]*a1 + SUMAS[0][2]*a2 == SUMAS_Y[0], SUMAS[1][0]*a0 + SUMAS[1][1]*a1 +SUMAS[1][2]*a2 == SUMAS_Y[1], SUMAS[2][0]*a0 + SUMAS[2][1]*a1 + SUMAS[2][2]*a2 == SUMAS_Y[2] ], a0, a1, a2, solution_dict=True)
			
			#Cree una lista de respuestas, porque Resp es simbólico y no deja cambiar a real
			Coefs += [Resp[0][a0].n(30)]
			Coefs += [Resp[0][a1].n(30)]
			Coefs += [Resp[0][a2].n(30)]
		
		elif Grado==3:
		
			a3, a2, a1, a0 = var('a3, a2, a1, a0')
			
			Resp = solve( [ SUMAS[0][0]*a0 + SUMAS[0][1]*a1 + SUMAS[0][2]*a2 + SUMAS[0][3]*a3 == SUMAS_Y[0], SUMAS[1][0]*a0 +SUMAS[1][1]*a1 + SUMAS[1][2]*a2 + SUMAS[1][3]*a3 == SUMAS_Y[1], SUMAS[2][0]*a0 + SUMAS[2][1]*a1 + SUMAS[2][2]*a2 +SUMAS[2][3]*a3 == SUMAS_Y[2], SUMAS[2][0]*a0 + SUMAS[2][1]*a1 + SUMAS[2][2]*a2 +SUMAS[2][3]*a3 + SUMAS[3][3]*a3 ==SUMAS_Y[3] ], a0, a1, a2, a3, solution_dict=True)
			
			#Cree una lista de respuestas, porque Resp es simbólico y no deja cambiar a real
			Coefs += [Resp[0][a0].n(30)]
			Coefs += [Resp[0][a1].n(30)]
			Coefs += [Resp[0][a2].n(30)]
			Coefs += [Resp[0][a3].n(30)]
		
		else:
			Coefs = ["Lo sentimos, modulo para grados > 3 en construccion !"]
	
	return Coefs

def MinCuad_Poli( points, Grado=1):
    C= MinCuad_Coefs(points, Grado)
    
    if Grado==1:
        return C[1]*x + C[0]
    elif Grado==2:
        return C[2]*x^2 + C[1]*x + C[0]
    elif Grado==3:
        return C[3]*x^3 + C[2]*x^2 + C[1]*x + C[0]


def MinCuad_Error ( points, Grado=1 ):
    C = MinCuad_Coefs(points, Grado)
    m = len(points)
    X, Y = zip(*points)
    z = var ('z')

    if Grado==1:
        f(z) = C[0] + C[1]*z
    elif Grado==2:
        f(z) = C[0] + C[1]*z + C[2]*z^2
    elif Grado==3:
        f(z) = C[0] + C[1]*z + C[2]*z^2 + C[3]*z^3 

    return sum( (Y[i]-f(X[i]))^2 for i in range( m ) )

def MinCuad_Plot(points, Grado=1):
    X,Y=zip(*points)

    f=MinCuad_Poli(points, Grado)
    
    return plot(f, X[0], X[-1] ) + list_plot(points)

	

###############################################################

#       DIFERENCIACIÓN NUMÉRICA

###############################################################

#   Fórmulas de 3 Puntos
def DifNum_Deriv3punt( Y , h,   Eval=1 ):
    '''
    Calcula la derivada por las fórmula de 3 puntos
    para una lista Y de 3 valores f(x).
    La diferencia de los valores consecutivos de x evaluados debe de ser h,
    o de lo contrario no se garantiza la efetividad de este método.
    Por default se utiliza la fórmula para el punto medio i.e. x_1
    Para escoger otro punto, Asignar 0 o 2 a Eval

    Sugerencia: si se tiene una lista de más de tres puntos,
                usar la notación Y[a:a+3] para obtener una sublista del 
                tamaño deseado a partir del índice a .
    '''
    
    if Eval== 0:
        #                (-3*f(x0) + 4f(x0+h) - f(x0+2h)
        res= ( 1/(2*h) )*( -3*Y[0] + 4*Y[1]   - Y[2] )

    elif Eval== 2:
        #                (f(x0-2h) - 4f(x0-h) + 3f(x0)
        res= ( 1/(2*h) )*(Y[0]     - 4*Y[1]   + 3*Y[2] )
    
    else: 
        res= ( 1/(2*h) )*(-Y[0] + Y[2] )

    return res
    

#   Fórmula de 5 Puntos
def DifNum_Deriv5punt( Y , h):
    '''
    Calcula la derivada por las fórmula de 5 puntos.
    para una lista Y de 5 valores f(x).
    La diferencia de los valores consecutivos de x evaluados debe de ser h,
    o de lo contrario no se garantiza la efectividad de este método.
    '''
    #TODO: obtener las otras fórmulas

    #                 ( f(x0-2h) - 8f(x0-h) + 8f(x0+h) - f(x0+2h))
    res= ( 1/(12*h) )*( Y[0]     - 8*Y[1]   + 8*Y[3]   - Y[4] )

    return res

#   Segunda derivada con 3 puntos
def DifNum_2aDev3Punt( Y, h ):

    #    1/h²    ( f(x0-h)-2f(x0)+f(x0+h) )
    res=(1/h^2)*( Y[0] - 2*Y[1] + Y[2] )

    return res

###############################################################

#       EXTRAPOLACIÓN DE RICHARDSON

###############################################################
def ExtDRich_N_j( N0 , j):
    '''
    devuelve la fórmulade aproximación N_j usando el método de estrapolación de Richardon
    dada la fórmula inicial N0 y j
    '''
    #TODO: aún no funciona :(
    var('x0, h')
    f=function('h')

    N = [N0]
    #recorrimos el rango de 1 a j, a , 0 a j-1 por simplicidad
    for i in range(1,j):
        N+= [ N[i-1](h/2) +( N[i-1](h/2) - N[i-1](h))/(2^(i-1)-1) ]

    return N[j-1]


###############################################################

#       INTEGRACIÓN NUMÉRICA

###############################################################
###############################################################

#       INTEGRACIÓN DE ROMBERG

###############################################################

def IntRomb( f, a, b, n, Aprox_num=false):
    '''
    Integral definida de a a b, de f
    Por el método de Romberg
    Para obtener una Aproximación numérica asigne true a Aprox_num
    '''
    h= [( b-a) /(2^(i-1)) for i in range(n+1) ]

    R= [ [0 for i in range(n+1)] for j in range(n+1)]
    
    R[1][1] = (h[0]/2)*(f(a)+f(b))

    #1era columna
    for k in range(2,n+1):
        R[k][1]= (R[k-1][1] + h[k-1])*sum( [f( x=(a + (2*i -1)*h[k] ) ) for i in [1 .. 2^(k-2)] ] )/2


    for k in range(2, n+1):
        for j in range(2, k+1):
            R[k][j]= R[k][j-1] +(R[k][j-1]- R[k-1][j-1]) / ( 4^(j-1) -1 )
    
    if Aprox_num == true:
        #TODO: se ve fea esta salida xd
        return list( map(lambda l : list(map(numerical_approx, l))  , R))
    else:
        return R

