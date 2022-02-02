# GrupoNach

Grupo Nach

Pregunta 6

El ciclo de vida del viewcontroller es el siguiente.

1- loadView el cual se ejecuta antes de que la app se ejecute por completo.

2-Viewdidload este viene por defecto cuando se crea el viewcontroller, prácticamente este es cuando la vista ya cargo pero no Visualmente sino que cargo en la memoria ram.

3-viewWillAppear se activa cuando algo va a aparecer. 

4- viewDidAppear es cuando algo ya apareció. 


5-didReceiveMemoryWarning es este es muy raro que se ejecute a menos que haya problemas de memoria ram, para evitar que la app se cierre de forma inesperada o genere problemas


Pregunta 7

Cicli de la vida de una app:

1- Planificación: Definir bien todos los objetivos y sus funcionalidades para poder realizarlos.
 
2-Desarrollo: los diseñadores y programadores comienzan a trabajar en el código y diseño para generar la app según las especificaciones plántelas en el desarrollo.

3-Test: Se comienzan a realizar pruebas de la funcionalidad de la app, en estos casos lo mas recomendable es que la app sea probada por personas externas al proyecto, y comenzar con la corrección de los errores realizados.

4-Lanzamiento: comenzar con los preparativo para el lanzamiento de la app y subir el resultado final a las diferentes plataformas para la descarga de los usuarios.

5-Motorización: comenzar a ver los comentarios de los usuarios para corregir errores de bugs que vayan surgiendo como forme descarga la app realizada.programando así mejoras y nuevas versiones que pueden llegar posterior mente.

Pregunta 8 

STRONG: Al menos que se decida especificar el tipo de referencia, Swift utiliza por defecto referencias STRONG, esto significa que un closure captura cualquier valor externo.que se utiliza dentro del closure y se asegura de nunca ser destruido.


WEAK: Swift permite especificar el tipo de referencia a utilizar y así determinar como serán capturados dentro del clsure. Closure no mantiene vivos o activos los valores  capturados como WEAK, por lo tanto pueden ser destruidos o igualados a Nil, una vez realizado esto como consecuencia la referencia Weak son siempre opcionales en Swift.

UNOWNED: Este es una alternativa para WEAK el cual se comporta como un ejecutor de unwrap implícito a opcional, al igual que la referencia WEAK la referencia UNOWNED permite que los valores puedan convertirse a Nil en cualquier lugar de la ejecución.


Pregunta 9


ARC Automatic Reference Counting o contador de referencias automáticas en español, es una funcionalidad que permite liberar memoria de aquellos elementos que posean referencias fuentes hace ellos,



Punto extra
Se vería  de color amarillo, ya que el viewdidload se ejecuta primero por que es cuando carga la memoria ram .



