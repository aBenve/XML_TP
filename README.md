# Trabajo practico Diseño y procesamiento de documentos XML

En este trabajo resolvimos el ejercicio de tomar datos de una *api-Rest*, estructurarlos y mostrarlos de manera clara.

## Compilacion
Para probar este ejercicio se toma el archivo tpe.sh con dos parametros:
1. El año(entre 2013 y 2021)
2. Un tipo de carrera conocida en Nascar("sc" "xf" "cw" "go" "mc" "enas")

Para poder ver el trabajo se debera tener en la misma carpeta los siguientes archivos
* extract_nascar_data.xq
* generate_markdown.xsl
* generate_markdown_html.html
* nascar_data.xsd
* remove_xmlns.xsl

El resultado que se vera es un archivo Makefile con los datos presentados ordenadamente por corredor.
