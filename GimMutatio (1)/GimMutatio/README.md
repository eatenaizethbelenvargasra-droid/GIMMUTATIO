# Gimnasio Mutatio

Sistema local de gestión administrativa y financiera para abrir en Visual Studio Code y ejecutar con XAMPP (Apache + MariaDB). Está hecho en PHP 8+, PDO y JavaScript/CSS sin Composer, Node ni servicios cloud.

## Funciones incluidas

- Acceso por roles: administrador, recepcionista y cliente; contraseñas con `password_hash`, sesión protegida, consultas preparadas, token CSRF y bitácora de cambios.
- Registro público de clientes, recuperación por enlace de correo de un solo uso, cambio de cuenta para cualquier rol y cambio de contraseña desde el perfil.
- Imagen de gimnasio en el acceso y foto de perfil JPG, PNG o WEBP (máximo 3 MB) para cada usuario.
- Registro, edición, consulta y desactivación de clientes. Al registrar se puede crear una contraseña de portal para que el cliente consulte su membresía e historial.
- Gestión de planes (precio, duración, activar/desactivar), membresías con fechas calculadas y registro del pago inicial.
- Registro e historial de pagos, control de asistencia con validación de membresía vigente y perfil del cliente.
- Dashboard, reportes por rango de fechas, descarga CSV e impresión.
- Análisis local de asistencia: agrupación k-means de frecuencia, regresión lineal del ingreso mensual y alertas de seguimiento basadas en reglas. El resultado orienta; no promete predicciones exactas.
- Asistente conversacional local que contesta preguntas sobre planes, pagos, vigencia y asistencia usando los datos del sistema. Los horarios y ubicación exacta deben completarse en este manual/código cuando el gimnasio confirme esos datos. No necesita OpenAI API.

## Requisitos

- XAMPP con Apache, PHP 8.0 o superior, las extensiones `pdo_mysql` y `mbstring`, y MariaDB/MySQL.
- Navegador actualizado.
- Visual Studio Code (opcional, para editar el proyecto).

## Instalación en Windows con XAMPP

1. Copia la carpeta `Gimnasio-Mutatio` a `C:\xampp\htdocs\Gimnasio-Mutatio`.
2. Abre el Panel de Control de XAMPP y enciende **Apache** y **MySQL**.
3. Ve a `http://localhost/phpmyadmin`.
4. Usa **Importar** y selecciona `database/mutatio.sql`. El script crea la base `gimnasio_mutatio`, tablas y planes iniciales.
5. Abre `http://localhost/Gimnasio-Mutatio/`.
6. En el primer acceso, el sistema crea las cuentas demo y un cliente demostrativo. Puedes editar el código en VS Code desde `C:\xampp\htdocs\Gimnasio-Mutatio`.

## Credenciales demo

| Rol | Usuario | Contraseña |
| --- | --- | --- |
| Administrador | `admin@mutatio.local` | `Mutatio2026!` |
| Recepción | `recepcion@mutatio.local` | `Recepcion2026!` |
| Cliente | `cliente@mutatio.local` | `Cliente2026!` |

La creación de las cuentas demo sucede únicamente cuando la tabla `users` está vacía. Cambia las contraseñas desde **Mi perfil** antes de ingresar información real. Los planes y precios que vienen con la base también son datos ilustrativos; reemplázalos con las tarifas reales desde **Membresías → Editar**.

## Configuración

Los valores predeterminados sirven para XAMPP local (MariaDB en `127.0.0.1`, usuario `root`, contraseña vacía). Si tu instalación difiere, cambia `config.php` o define las variables de entorno `MUTATIO_DB_HOST`, `MUTATIO_DB_NAME`, `MUTATIO_DB_USER` y `MUTATIO_DB_PASS`.

Si ya importaste una versión previa del proyecto, importa una vez `database/upgrade_profiles_recovery.sql` antes de usar el registro, recuperación de contraseña y fotos de perfil. Para enlaces de recuperación, configura el envío SMTP/mail de PHP en XAMPP y ajusta `MUTATIO_BASE_URL` y `MUTATIO_MAIL_FROM` en el entorno o `base_url`/`mail_from` en `config.php`. Usa `http://localhost/Gimnasio-Mutatio` como base URL si mantienes el nombre de carpeta sugerido. Sin SMTP/mail configurado, registro e inicio de sesión funcionan, pero los mensajes de recuperación no podrán llegar al correo.

El registro público crea cuentas de cliente. Para asociar una cuenta nueva con un cliente que ya estaba en el sistema, la persona debe introducir el mismo correo y CI registrados. Las cuentas de administración y recepción se crean desde el módulo Usuarios. Todos los roles pueden cambiar de cuenta desde **Cambiar cuenta** en la barra lateral y actualizar su foto y contraseña desde **Mi perfil**.

Para el portal del cliente, al crear un cliente nuevo escribe una contraseña de 10 caracteres o más. Una cuenta existente no se crea automáticamente al editar clientes.

## Árbol del proyecto

```text
Gimnasio-Mutatio/
├── assets/                 estilos y JavaScript
├── assets/gym-hero.svg     imagen local para la pantalla de acceso
├── database/mutatio.sql    esquema MariaDB y planes iniciales
├── database/upgrade_profiles_recovery.sql  actualización de una instalación previa
├── views/                  pantallas de cada módulo
├── uploads/profiles/       fotos de perfil
├── app.php                 sesión, conexión PDO, utilidades y demo
├── assistant.php           respuestas conversacionales locales
├── register.php            alta segura de clientes
├── forgot-password.php     solicitud de restablecimiento
├── reset-password.php      enlace de un solo uso
├── config.php              conexión y zona horaria
├── index.php               rutas, permisos y acciones del sistema
└── README.md               instalación y uso
```

## Notas de operación

- Para que una persona use el portal debe existir un cliente asociado a una cuenta de rol `cliente`. El formulario de alta puede crear esa cuenta a la vez.
- Recepción registra asistencias; administración además administra clientes, planes, pagos, usuarios e informes.
- Los importes se expresan en bolivianos (Bs).
- La base inicia con tres planes y montos de demostración; sustituye esos datos por los precios reales antes de usar el sistema con clientes.
- Los pagos y registros financieros se conservan para auditoría; un cliente se desactiva en vez de borrarse físicamente.
- XAMPP es un entorno local: el sistema está disponible mientras Apache y MariaDB estén iniciados. Haz copias de seguridad periódicas desde phpMyAdmin (**Exportar**) y restringe el sistema a la red local. No publiques XAMPP directamente en Internet. En producción configura HTTPS, contraseñas propias, un usuario MariaDB de privilegios limitados y respaldos externos.

## Relación con la especificación

La solución implementa las historias HU01–HU07 y RF01–RF10 del documento: clientes, membresías, pagos e historial, reportes, consulta personal, asistencia y análisis. También incluye RNF01–RNF06 en términos de acceso por rol, contraseñas protegidas, interfaz adaptable a móviles y operaciones SQL preparadas. El uso de XAMPP/PHP satisface la preferencia de ejecución local solicitada; el documento menciona Django/MySQL y OpenAI como herramientas posibles, no como una dependencia necesaria.
