# 📅 Calendario Flutter Pro

Una aplicación web interactiva desarrollada con **Flutter** para la gestión visual de eventos, reuniones y tareas personales. Ofrece un diseño moderno con interfaz oscura, navegación dinámica y modales emergentes intuitivos.

---

## 🚀 Características Principales

* **Vistas Dinámicas**: Permite alternar fácilmente entre la agenda del **Día**, la distribución de la **Semana** y el mapa general del **Mes**.
* **Gestión de Eventos**:
  * Visualización clara de la agenda mensual categorizada por colores (Salud, Estudio, Trabajo).
  * Modal emergente interactivo para registrar un **Nuevo Evento** indicando título y horario.
* **Diseño Personalizado**:
  * Paleta de colores ajustada en tonos oscuros con acentos en violeta (`#8B5CF6`) y rosa (`#EC4899`).
  * Indicadores visuales para el día seleccionado y eventos programados.
* **Navegación Fluida**: Controles para cambiar de mes y botones táctiles rápidos.

---

## 🛠️ Tecnologías Utilizadas

* **Framework**: Flutter (Dart)
* **Plataforma Objetivo**: Web (Google Chrome)
* **Librerías Estándar**: `flutter/material.dart`

---

## 💻 Instalación y Ejecución

1. **Clonar el repositorio**:
   ```bash
   git clone <https://github.com/naomisanchez-coder/Laboratorio_Calendario>
   cd laboratorio_calendario

Obtener las dependencias:
flutter pub get

Ejecutar en el navegador:
flutter run -d chrome

---

### Explicación del Proyecto 

Para este proyecto desarrollé una aplicación de calendario digital enfocada en ser práctica y fácil de usar. Mi objetivo principal fue crear una pantalla donde cualquier persona pudiera ver rápidamente sus compromisos del día, la semana o el mes completo sin complicaciones. 

Durante el desarrollo ajusté los colores para mantener un estilo oscuro elegante que no canse la vista, solucionando detalles en el código para que todos los colores se mostraran de forma uniforme. También agregué un botón para agregar nuevos eventos mediante una pequeña ventana emergente y organicé la lista inferior para que muestre el estado de cada actividad con etiquetas de colores según el tipo de tarea.

---

### Conclusiones del Desarrollo

1. **Optimización Visual y Corrección de Estilos**  
   Al corregir la referencia del color en la paleta principal, logré que la aplicación fuera completamente estable durante la compilación. Esto me enseñó la importancia de utilizar adecuadamente los componentes visuales estándar para evitar fallos de ejecución en el navegador.

2. **Flexibilidad en la Experiencia de Usuario**  
   Implementar tres formas distintas de visualizar el calendario (diaria, semanal y mensual) permitió adaptar el uso de la pantalla a diferentes necesidades, haciendo que la navegación entre fechas sea intuitiva y la información fácil de consultar.

3. **Modularidad y Preparación para Nuevas Funciones**  
   El diseño estructurado en componentes me permitió integrar un cuadro emergente para registrar eventos y una sección inferior de agenda general, dejando la base lista para conectar una base de datos o guardar información de manera permanente en el futuro.