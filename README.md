# Procesos Estocásticos - Entorno de Análisis

Este proyecto proporciona un entorno reproducible para analizar un conjunto de datos clasificado y resolver los puntos del trabajo práctico de Probabilidad y Procesos Estocásticos. Incluye contenidos listos para usarse en Docker (imagen, `docker-compose`) y un cuaderno de Jupyter con cada paso del análisis estadístico requerido.

## Requisitos

- Docker 20.10+ y Docker Compose Plugin 2.0+
- (Opcional) `make` para utilizar las tareas predefinidas
- (Opcional) Ejecución local sin Docker: Python 3.11 y las dependencias listadas en `requirements.txt`

## Imagen Docker

La imagen se basa en `python:3.11-slim` e instala las siguientes dependencias principales:

- JupyterLab / Notebook
- pandas, numpy, scipy, scikit-learn, statsmodels
- seaborn, matplotlib, plotly
- sympy, ipywidgets

## Uso rápido

1. **Construir la imagen**
   ```bash
   make build
   ```

2. **Iniciar JupyterLab (Docker Compose)**
   ```bash
   docker compose up
   ```
   Luego abre <http://localhost:8888> en tu navegador. El servidor arranca sin token.

   Para detener el servicio:
   ```bash
   docker compose down
   ```

3. **Alternativas con Makefile**
   - Ejecutar el contenedor en segundo plano (idéntico a Compose):
     ```bash
     make notebook
     ```
   - Abrir una terminal interactiva dentro del contenedor:
     ```bash
     make shell
     ```
   - Detener la instancia creada con `make notebook`:
     ```bash
     make stop
     ```

Todos los comandos montan el proyecto en `/workspace` dentro del contenedor, por lo que los cambios en notebooks y archivos se reflejan en tu máquina.

## Estructura relevante

- `Dockerfile`: Imagen con Python 3.11 y librerías estadísticas.
- `docker-compose.yml`: Servicio `notebook` que expone JupyterLab en el puerto 8888.
- `Makefile`: Tareas `build`, `notebook`, `shell`, `stop`, `clean` para orquestar Docker.
- `data/data.csv`: Conjunto de datos clasificado utilizado en el análisis.
- `notebooks/part_a_distribution_fitting.ipynb`: Cuaderno con los pasos (a)–(i) del trabajo:
  1. Selección de variables clave y ajuste de distribuciones (criterio AIC).
  2. Covarianza teórica vs. muestral.
  3. Pruebas de independencia entre pares de variables.
  4. Correlaciones y diagramas de dispersión.
  5. Cálculo de componentes principales.
  6. Decorrelación y whitening.
  7. Clasificador Bayesiano para dos clases con matriz de confusión.
  8. Superficie de decisión en 3D usando las dos variables de mayor varianza.
  9. Probabilidad de error teórica y comparación con el error empírico.

## Flujo de trabajo sugerido

1. Construye la imagen (`make build`).
2. Ejecuta JupyterLab (`docker compose up` o `make notebook`).
3. Abre `notebooks/part_a_distribution_fitting.ipynb` y ejecuta las celdas en orden.
4. Documenta los resultados en tu informe académico.

## Mantenimiento

- Si agregas nuevas dependencias Python, modifícalas en el `Dockerfile` y reconstruye la imagen.
- Para ejecutar localmente, crea un entorno virtual e instala con `pip install -r requirements.txt`.
- Para reiniciar el entorno desde cero, usa `docker compose down --volumes` y vuelve a levantar el servicio.

## Licencia

Este repositorio se distribuye exclusivamente para fines académicos. Ajusta o complementa según las políticas de tu institución.
