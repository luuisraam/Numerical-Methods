###################################################################################################

#       DIFERENCIACIÓN NUMÉRICA
#
#	Ramos Guerrero Luis
#	Métodos Numéricos 2
#	Lic. en Matemáticas Aplicadas y Computación, UNAM

##################################################################################################


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def main():

    print("\n\t\t  - D I F E R E N C I A C I Ó N   N U M É R I C A -")

    while true:

        print("\n\n\t [  D A T O S  ]")
        print("\n\t Selecciona la formula:")
        print("\t   [1] Progresiva / Regresiva")
        print("\t   [2] Tres Puntos Central")
        print("\t   [3] Tres Puntos Progresiva")
        print("\t   [4] Cinco Puntos Central")
        print("\t   [5] Cinco Puntos Progresiva")
        print("\t   [6] Segunda Derivada")
        option = int( input("\n\t ►  ") )

        if option < 1 or option > 6:
            print("\n\t [!]Error: Opcion no existente.")
            continue
            
        print("\n\t Valor de h:")
        h = float( input("\n\t ►  ") )
        print_sol ( option )
        Y = list( eval( input("\n\t ►  ") ) )


        if option == 1:
            if len( Y ) != 2:
                print ("\n\t Debes ingresar 2 valores f(x0), f(x0 + h).")
                continue
            else:
                f_dif = dif_progressive( h, Y )
                break;

        elif option == 2:
            if len( Y ) != 2:
                print ("\n\t Debes ingresar 2 valores f(x0 - h), f(x0 + h).")
                continue
            else:
                f_dif = dif_3pCentral( h, Y )
                break;
                
        elif option == 3:
            if len( Y ) != 3:
                print ("\n\t Debes ingresar 3 valores f(x0), f(x0 + h), f(x0 + 2h).")
                continue
            else:
                f_dif = dif_3p( h, Y )
                break;
                
        elif option == 4:
            if len( Y ) != 4:
                print ("\n\t Debes ingresar 4 valores f(x0 - 2h), f(x0 - h), f(x0 + h), f(x0 + 2h).")
                continue
            else:
                f_dif = dif_5pCentral( h, Y )
                break;

        elif option == 5:
            if len( Y ) != 5:
                print ("\n\t Debes ingresar 5 valores f(x0), f(x0 + h), f(x0 + 2h), f(x0 + 3h), f(x0 + 4h):.")
                continue
            else:
                f_dif = dif_5p( h, Y )
                break;

        elif option == 6:
            if len( Y ) != 3:
                print ("\n\t Debes ingresar 3 valores f(x0 - h), f(x0), f(x0 + h).")
                continue
            else:
                f_dif = dif2_p( h, Y )
                break;
                
        else:
            pass


    print("\n\n\n\t [  R E S U L T A D O S  ]")

    print ("\n\t ■  F_dif(x0) = ", f_dif)


    return


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def print_sol ( option ):

	if option == 1:
			print ("\n\t Escribe los valores f(x0), f(x0 + h):")
	elif option == 2:
		print ("\n\t Escribe los valores f(x0 - h), f(x0 + h):")
	elif option == 3:
		print ("\n\t Escribe los valores f(x0), f(x0 + h), f(x0 + 2h):")	
	elif option == 4:
		print ("\n\t Escribe los valores f(x0 - 2h), f(x0 - h), f(x0 + h), f(x0 + 2h):")
	elif option == 5:
		print ("\n\t Escribe los valores f(x0), f(x0 + h), f(x0 + 2h), f(x0 + 3h), f(x0 + 4h):")
	elif option == 6:
		print ("\n\t Escribe los valores f(x0 - h), f(x0), f(x0 + h):")
		
	return


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def dif_progressive( h, Y ):
    return (Y[1] - Y[0]) / h

# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def dif_3pCentral( h, Y ):
    return (Y[1] - Y[0]) / (2*h)


# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def dif_3p( h, Y ):
    return (-3*Y[0] + 4*Y[1] - Y[2]) / (2*h)

# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def dif_5pCentral( h, Y ):
    return (Y[0] - 8*Y[1] + 8*Y[2] - Y[3]) / (12*h)

# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def dif_5p( h, Y ):
    return (-25*Y[0] + 48*Y[1] - 36*Y[2] + 16*Y[3] - 3*Y[4]) / (12*h)

# < >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >
def  dif2_p( h, Y ):
    return (Y[0] - 2*Y[1] + Y[2]) / (h**2)
	



if __name__ == '__main__':
    import sys
    sys.exit( main() )
