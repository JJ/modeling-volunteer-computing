#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Script para convertir los ficheros *.log en *.csv.

Usage: log2.csv input_file output_file [field1 [field2 [...]]]

Toma los dato de un archivo *.log y crea un *.csv con ellos.

Al ejecutar el programa es necesario indicar el nombre del archivo *.log de
entrada y el del *.cvs de salida, por ese orden.

Opcionalmente, a continuación se pueden indicar por orden los campos que se
desean extraer par el *.csv. Si no se indica ninguno se usaran los siguientes:

"chromosome","fitness","IP","timestamp"

Las filas en las que falte uno o más de esos campos serán ignoradas.

Si se usa el campo "timestamp", este se divide automáticamente en un campo
"date" y un campo "time".
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

# Campos que se extraerán si no se indica ninguno
campos_por_defecto = ["chromosome","fitness","IP","timestamp"]

def procesa(input_file, output_file, campos):
    """
    El primer argumento es El archivo *.log de entrada,
    el segundo el *.csv de salida,
    el tercero es la lista de campos que se extraerán.
    """
    
    ruta_log = input_file
    ruta_csv = output_file

    lista_lineas = list()

    #Abrimos el fichero de entrada en modo lectura
    fichero_entrada = open(ruta_log,"r")

    for linea in fichero_entrada:

        lista_lineas.append(ast.literal_eval(linea))

    #Abrimos el fichero de salida en modo escritura
    fichero_salida = open(ruta_csv,"w")

    # Cabecera del CSV

    fila_csv_actual = ""

    for item in campos:

        if item == "timestamp":
            item = 'date","time'

        if fila_csv_actual == "":
            fila_csv_actual += '"' + item + '"'
        else:
            fila_csv_actual += ',"' + item + '"'

    fila_csv_actual += "\n"
    fichero_salida.write(fila_csv_actual)


    # Vamos procesando e imprimiendo cada fila del CSV

    for diccionario in lista_lineas:

        try:
            fila_csv_actual = ""

            for item in campos:

                if item == "timestamp":
                    fh1, fh2 = diccionario["timestamp"].split("T")
                    diccionario["timestamp"] = fh1 + '","' + fh2

                if fila_csv_actual == "":
                    fila_csv_actual += '"' + str(diccionario[item]) + '"'
                else:
                    fila_csv_actual += ',"' + str(diccionario[item]) + '"'

            if fila_csv_actual != "":
                fila_csv_actual += "\n"

            fichero_salida.write(fila_csv_actual)
        except:
            pass

    fichero_entrada.close()
    fichero_salida.close()

if len(sys.argv) > 3:
    campos = sys.argv[3:]
else:
    campos = campos_por_defecto

if len(sys.argv) > 2:

    procesa(sys.argv[1],sys.argv[2],campos)

else:

    print __doc__

