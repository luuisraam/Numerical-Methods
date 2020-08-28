# //
# Método de Newton
#
# //


from prettytable import PrettyTable

# ----------------------------------------------------------------------------------------
#  [Funcion]
#	name: main
# ---------------------------------------------------------------------------------------- 
def main():

	x, y, z, w = var('x y z w')
	val_norma = None
	
	print('\n Sea un Sistema de Ecuaciones no Lineales S(f(x,y,z), g(x,y,z), h(x,y,z), i(x,y,z)),')
	print('Ingresa los siguientes datos: ')
	
	f(x,y,z,w) = eval(input('\n\t f(x,y,z): '))
	g(x,y,z,w) = eval(input('\t g(x,y,z): '))
	h(x,y,z,w) = eval(input('\t h(x,y,z): '))
	
	x_ = eval(input('\n\t Valor inicial de x: '))
	y_ = eval(input('\t Valor inicial de y: '))
	z_ = eval(input('\t Valor inicial de z: '))
	
	max_iteraciones = int(input('\n\t Max de iteraciones: '))
	tolerancia = eval(input('\t Tolerancia: '))
	
	# Esta funcion es el sistema de ecuaciones
	G(x,y,z,w) = (f,g,h)
		
	# Se calcula el Jacobiano
	matriz_j = matrix(jacobian(G(x,y,z),(x,y,z)))

	# Se asignan las funciones del Jacobiano para su posterior evaluacion
	J_00(x,y,z)=matriz_j[0][0]; J_01(x,y,z)=matriz_j[0][1]
	J_02(x,y,z)=matriz_j[0][2];
	J_10(x,y,z)=matriz_j[1][0]; J_11(x,y,z)=matriz_j[1][1]
	J_12(x,y,z)=matriz_j[1][2]; 
	J_20(x,y,z)=matriz_j[2][0]; J_21(x,y,z)=matriz_j[2][1]
	J_22(x,y,z)=matriz_j[2][2]; 

		
	t = PrettyTable()
	t.field_names= ['[k]','x_1','x_2','x_3','Error']
	t.add_row(['[0]',x_,y_,z_,'N/A'])
		
	print('\n\t METODO DE NEWTON - ITERACIONES')
		
	for j in range(max_iteraciones):
		
		# Evalua el Jacobino 
		matriz_j[0,0]=J_00(x_,y_,z_); matriz_j[0,1]=J_01(x_,y_,z_)
		matriz_j[0,2]=J_02(x_,y_,z_); 
		matriz_j[1,0]=J_10(x_,y_,z_); matriz_j[1,1]=J_11(x_,y_,z_)
		matriz_j[1,2]=J_12(x_,y_,z_); 
		matriz_j[2,0]=J_20(x_,y_,z_); matriz_j[2,1]=J_21(x_,y_,z_)
		matriz_j[2,2]=J_22(x_,y_,z_); 
		
		v = vector([x,y,z])
		matriz_sistema = matriz_j*v
		
		j1(x,y,z)=matriz_sistema[0]
		j2(x,y,z)=matriz_sistema[1]
		j3(x,y,z)=matriz_sistema[2]

		
		a = float(-1*f(x_,y_,z_))
		b = float(-1*g(x_,y_,z_))
		c = float(-1*h(x_,y_,z_))

		
		solns = solve([j1 == a, j2==b, j3==c ], x,y,z, solution_dict=True)
		
		r1 = solns[0][x].n()
		r2 = solns[0][y].n()
		r3 = solns[0][z].n()
		
		
		x_k = x_ + r1
		y_k = y_ + r2
		z_k = z_ + r3

		
		val_norma = norma_infinito(x_k-x_,y_k-y_,z_k-z_)
		
		t.add_row(['[' + str(j+1) + ']', x_k, y_k, z_k, val_norma ])
		
		if val_norma <= tolerancia:
			break
		else:
			pass
			
		x_=x_k 
		y_=y_k 
		z_=z_k
		
	
	print (t)
	

	
	
	# [1]	Siempre mantener en memoria la iteracion k y la iteracion k-1.

# ----------------------------------------------------------------------------------------
#  [Funcion]
#	Recibe las componenetes del vector y retorna la norma infinito.
#	name: norma_infinito
#  	@param x,y,z
#  	@return max(abs(x),abs(y),abs(z))
# ---------------------------------------------------------------------------------------- 
def norma_infinito (x,y,z):
	return max(abs(x),abs(y),abs(z))


if __name__ == '__main__':
	import sys
	sys.exit(main())
