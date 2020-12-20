# //
# Método de Punto Fijo
#
# Se solicitará al usuario ingresar de forma simbólica el valor de cada incógnita ya despe
# jada, debido a que la funcion solve() no siempre devuelve el despeje simbólico. 
# Resuelve sistemas de máximo tres incógnitas.
# //


from prettytable import PrettyTable

# ----------------------------------------------------------------------------------------
#  [Funcion]
#	name: main
# ---------------------------------------------------------------------------------------- 
def main():

    x, y, z = var('x y z')
    val_norma = None

    print('\n Sea un Sistema de Ecuaciones no Lineales S(f(x,y,z), g(x,y,z), h(x,y,z)),')
    print('y sean x = F(), y = G(), z = H() las variables ya despejadas.')
    print('Ingresa los siguientes datos: ')

    f(x,y,z) = eval(input('\n\t Valor simbolico de x: '))
    g(x,y,z) = eval(input('\t Valor simbolico de y: '))
    h(x,y,z) = eval(input('\t Valor simbolico de z: '))

    x_ = eval(input('\n\t Valor inicial de x: '))
    y_ = eval(input('\t Valor inicial de y: '))
    z_ = eval(input('\t Valor inicial de z: '))

    max_iteraciones = int(input('\n\t Max de iteraciones: '))
    tolerancia = eval(input('\t Tolerancia: '))

    print('\n\t METODO DE PUNTO FIJO - ITERACIONES')

    t = PrettyTable()
    t.field_names= ['[k]','x_1','x_2','x_3','Error']
    t.add_row(['[0]',x_,y_,z_,'N/A'])

    for i in range(max_iteraciones):
        
        # NOTA [1]
        x_k = f(x_,y_,z_)
        y_k = g(x_,y_,z_)
        z_k = h(x_,y_,z_)
        val_norma = norma_infinito(x_k-x_,y_k-y_,z_k-z_)
        
        t.add_row(['[' + str(i+1) + ']', x_k.n(30), y_k.n(30), z_k.n(30), val_norma.n(30)])

        if val_norma <= tolerancia:
            break
        else:
            pass

        x_=x_k
        y_=y_k
        z_=z_k
        
        
    print(t)

    # [1] Usar x_ = f_x(x_,y_,z_) haria que la sig funcion reciba el nuevo valor de x_
    #     que seria equivalente al método de Gauss-Seidel. Siempre mantener en memoria
    #	la iteracion k y la iteracion k-1


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
