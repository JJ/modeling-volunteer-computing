#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Script para convertir los ficheros *.log en *.csv.

Sólo extrae las filas con campo "chromosome", y sólo parte de los campos (Los que incho necesita)
"""


"""
    Copyright 2015 psicobyte@gmail.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""



import ast, sys

def procesa(input_file, output_file):
"""
El primer argumento es El archivo *.log de entrada, el segundo el *.csv de salida
"""

    ruta_log = input_file
    ruta_csv = output_file

    lista_lineas = list()

    #Abrimos el fichero de entrada en modo lectura
    fichero = open(ruta_log,"r")

    for linea in fichero:

        lista_lineas.append(ast.literal_eval(linea))

    #Abrimos el fichero de salida en modo escritura
    fichero_salida = open(ruta_csv,"w")

    # Cabecera del CSV
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

if len(sys.argv) > 2:

    procesa(sys.argv[1],sys.argv[2])

else:
    print "Usage: log2.csv input_file output_file"
