#!/usr/bin/python
# -*- coding: utf-8 -*-

import ast, sys

ruta_log = sys.argv[1]
ruta_csv = sys.argv[2]

lista_lineas = list()

#Abrimos el fichero en modo lectura
fichero = open(ruta_log,"r")



for linea in fichero:

    lista_lineas.append(ast.literal_eval(linea))




fichero_salida = open(ruta_csv,"w")

elemento = '"chromosome","fitness","IP","date","time"\n'
fichero_salida.write(elemento)


for diccionario in lista_lineas:

    try:
 
        fh1, fh2 = diccionario["timestamp"].split("T")
        fh = '"' + fh1 + '","' + fh2 + '"'

        elemento = '"' + str(diccionario["chromosome"]) + '","' + str(diccionario["fitness"]) + '","' + str(diccionario["IP"]) + '","' + fh + '"\n'
        fichero_salida.write(elemento)
    except:
        pass



fichero.close()
fichero_salida.close()
