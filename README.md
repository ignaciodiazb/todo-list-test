# Todo List Test

Este proyecto consiste en una app para manejar tareas (todo list).

Las principales funciones son crear, editar y eliminar tareas. Además, es posible actualizar el estado de las tareas desde la vista principal.

## Env

Este proyecto utiliza `dotenv-rails` para manejar variables de entorno, por lo que es necesario crear un archivo .env para su correcto funcionamiento en un entorno local:

```
OPENAI_ACCESS_TOKEN=your-access-token
```

## Preguntas

### Qué partes del código generaste o modificaste con la ayuda de IA?

En este proyecto, principalmente las vistas fueron desarrolladas con IA, para acelerar el desarrollo y lograr una mayor consistencia a nivel visual.

Los generadores de Ruby on Rails fueron también de gran ayuda para generar el boilerplate de modelos, controladores y vistas.

### Cómo hiciste la validación de ese código (¿lo revisaste línea por línea?, ¿ejecutaste pruebas?, ¿lo modificaste?).

La validación que realizo es un mix de revisión manual y testing automatizado.

El core de este proyecto es un CRUD, por lo que mantuve un enfoque lo más simple posible y escribí algunos tests para el `TodosController`. La idea es que cualquier cambio introducido, no rompa la funcionalidad existente.

Además, luego de generar cambios con un agente, hago una revisión general de los cambios para ver si se ajusta a mi planificación.

### Por qué tomaste ciertas decisiones de diseño o arquitectura, incluso si la IA las sugirió. Por ejemplo, "La IA me propuso usar este ORM, pero lo modifiqué para que se ajustara a nuestra base de datos".

Las decisiones de diseño que tome están relacionadas con principios de programación y prácticas recomendadas en Ruby on Rails (en este caso).

En este sentido, busque separar las responsabilidades y delegarlas a sus respectivos actores (controladores, vistas, modelos).

Al momento de generar interfaces, mi toma de decisiones se basó principalmente en generar consistencia en toda la app, un flujo intuitivo, y nociones básicas de diseño.

### Alguna parte del código que consideres que la IA te generó de forma "incorrecta" o que tuviste que reajustar para que funcionara como esperabas.

Hay algunos ejemplos en los que tuve que realizar más ajustes para llegar al resultado deseado:

- Al momento de generar el modelo inicial de Todo, la IA me sugirió manejar el estado de las tareas con un enum, sin embargo, opté por usar una columna de tipo boolean, ya que realmente las tareas pueden tener 2 posibles estados: completada o no completada. Si fuera una app más compleja, consideraría otro tipo de dato para esta propiedad.
- La sugerencia inicial de la vista index de Todo, que permite cambiar el estado de las tareas, utilizaba un checkbox y un label con un link que al hacer click te llevaba a la página de cada Todo. El problema con esta estrategia es que para tecnologías asistivas o navegación con el teclado, se espera que al hacer click en el label, sea equivalente a hacer click en el checkbox, por lo que es un resultado inesperado.
- Para realizar el cálculo de tiempo estimado (`estimated_time`) para completar un Todo, la IA propuso inicialmente un model callback de tipo `after_validation`. El problema es que si por x motivo el cálculo falla, u OpenAI no está operativo, esto bloquearía la creación de un Todo. La estimación es una feature "nice to have", pero no debería bloquear este flujo si no está disponible, por lo que opté por un background job.

### Cuánto tiempo te tomó hacer el ejercicio.

Aproximadamente entre 4 y 5 horas.
