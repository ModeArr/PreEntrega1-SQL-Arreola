# <center>1er Prentrega de proyecto final</center>
Alumno: Modesto Rafael Alejandro Arreola Lira

Comisión 59410 SQL

Tutor: Melina Solorzano

Docente: Anderson Michel Torres

---

### **Consignas:**
- El documento debe contener:
    - Introducción
    - Objetivo
    - Situación problemática
    - Modelo de negocio
    - Diagrama de entidad relación
    - Listado de tablas con descripción de estructura (columna,descripción, tipo de datos, tipo de clave)

---

## Introducción
Se busca hacer una base de datos relacional para un ecommerce, que permita hacer compras de manera eficiente y dinámica; esto mediante un carrito de compras.

## Objetivo
Proveer de un sistema simple que permita realizar compras y asi mismo mantener datos para uso de marketing de todas las ventas y usuarios.

## Modelo de negocio
1. **Registrar usuarios y guardar su datos**: Necesitamos que la base de datos guarde usuarios y sus datos como son direcciones y métodos de pagos, esto para dar una experiencia mejorada al usuario.

2. **Gestión de productos**: Es importante tener un sistema que permita guardar los productos asi como manejar su inventario y categorías. Asi también se necesita tener un control de los descuentos.

3. **Compra mediante un carrito de compras**: La base de datos debe permitirnos hacer la compra de productos mediante un carrito de compras y poder registrar las sesiones de compras de cada carrito para tener un control de marketing de donde y cuando se quedan en el proceso de compras.

4. **Registro de ventas**: Necesitamos un sistema que pueda registrar de manera detallada cada compra hecha y todos sus detalles y que esta sea fácil para el departamento de ventas poder verificarla a fondo.

## Diagrama entidad relación (DER)
![ecommerce diagram](https://github.com/user-attachments/assets/906d5806-6fa5-4cfe-a245-9380599119fb)


## Listado de tablas y descripción
### Tabla `product_inventory`
Esta tabla almacena la información del inventario de los productos, incluyendo la cantidad disponible y las fechas de creación, modificación y eliminación.

| Columna       | Tipo de Dato  | Atributo                                 | Descripción                                   |
|---------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`          | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único de inventario.            |
| `quantity`    | INT UNSIGNED  | NOT NULL                                 | Cantidad disponible en inventario.            |
| `created_at`  | DATETIME      | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at` | DATETIME      |                                          | Fecha y hora de la última modificación.       |
| `deleted_at`  | DATETIME      |                                          | Fecha y hora de la eliminación lógica.        |

### Tabla `discount`
Esta tabla contiene la información relacionada con los descuentos aplicables a los productos, incluyendo el nombre, porcentaje de descuento y su estado de activación.

| Columna            | Tipo de Dato     | Atributo                                 | Descripción                                   |
|--------------------|------------------|------------------------------------------|-----------------------------------------------|
| `id`               | INT              | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único del descuento.            |
| `name`             | VARCHAR(80)      | NOT NULL                                 | Nombre del descuento.                         |
| `description`      | VARCHAR(120)     |                                          | Descripción breve del descuento.              |
| `discount_percent` | TINYINT UNSIGNED | NOT NULL                                 | Porcentaje de descuento aplicado.             |
| `active`           | TINYINT(1)       | NOT NULL, DEFAULT 0                      | Estado del descuento (1: activo, 0: inactivo).|
| `created_at`       | DATETIME         | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at`      | DATETIME         |                                          | Fecha y hora de la última modificación.       |
| `deleted_at`       | DATETIME         |                                          | Fecha y hora de la eliminación lógica.        |

### Tabla `product_category`
Esta tabla almacena las categorías de los productos, permitiendo organizar los productos en diferentes grupos.

| Columna       | Tipo de Dato  | Atributo                                 | Descripción                                   |
|---------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`          | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único de la categoría.          |
| `name`        | VARCHAR(80)   | NOT NULL                                 | Nombre de la categoría de producto.           |
| `description` | VARCHAR(180)  |                                          | Descripción breve de la categoría.            |
| `created_at`  | DATETIME      | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at` | DATETIME      |                                          | Fecha y hora de la última modificación.       |
| `deleted_at`  | DATETIME      |                                          | Fecha y hora de la eliminación lógica.        |

### Tabla `product`
Esta tabla contiene información sobre los productos disponibles para la venta, incluyendo su nombre, descripción, SKU, categoría, inventario, precio y descuentos aplicables.

| Columna       | Tipo de Dato  | Atributo                                 | Descripción                                   |
|---------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`          | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único del producto.             |
| `name`        | VARCHAR(100)  | NOT NULL                                 | Nombre del producto.                          |
| `description` | VARCHAR(300)  |                                          | Descripción detallada del producto.           |
| `SKU`         | VARCHAR(50)   | NOT NULL                                 | Código único de inventario del producto (SKU).|
| `category_id` | INT           | NOT NULL                                 | Clave foránea a la tabla `product_category`.  |
| `inventory_id`| INT           | NOT NULL                                 | Clave foránea a la tabla `product_inventory`. |
| `price`       | DECIMAL(10,2) | NOT NULL                                 | Precio del producto.                          |
| `discount_id` | INT           | NOT NULL, DEFAULT 0                      | Clave foránea a la tabla `discount`.          |
| `created_at`  | DATETIME      | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at` | DATETIME      |                                          | Fecha y hora de la última modificación.       |
| `deleted_at`  | DATETIME      |                                          | Fecha y hora de la eliminación lógica.        |

### Tabla `order_details`
Esta tabla almacena los detalles de los pedidos realizados por los usuarios, incluyendo el total del pedido y el método de pago.

| Columna       | Tipo de Dato  | Atributo                                 | Descripción                                   |
|---------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`          | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único del pedido.               |
| `user_id`     | INT           | NOT NULL                                 | Clave foránea a la tabla `user`.              |
| `total`       | DECIMAL(10,2) | NOT NULL                                 | Total del pedido.                             |
| `payment_id`  | INT           | NOT NULL                                 | Clave foránea a la tabla `payment_details`.   |
| `created_at`  | DATETIME      | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at` | DATETIME      |                                          | Fecha y hora de la última modificación.       |

### Tabla `payment_details`
Esta tabla guarda los detalles de los pagos realizados, incluyendo el proveedor de pagos y el estado del pago.

| Columna        | Tipo de Dato        | Atributo        | Descripción                                                                 |
|--------------------|-------------------------|---------------------|---------------------------------------------------------------------------------|
| `id_payment_details`| INT                     | PRIMARY KEY, NOT NULL, AUTO_INCREMENT | Identificador único del detalle de pago.                                         |
| `order_id`         | INT                     | NOT NULL            | Identificador de la orden asociada al pago. Referencia a `order_details`.        |
| `amount`           | DECIMAL(10,2)           | NOT NULL            | Monto total pagado por la orden.                                                |
| `provider`         | VARCHAR(45)             | NOT NULL            | Proveedor del servicio de pago (ej. PayPal, Stripe, Banco, etc.).                |
| `status`           | ENUM('pending', 'successful', 'failed', 'refunded') | NOT NULL, DEFAULT 'pending' | Estado del pago: pendiente, exitoso, fallido o reembolsado.                    |
| `payment_method`    | VARCHAR(45)             | NOT NULL            | Método de pago utilizado (ej. tarjeta de crédito, transferencia bancaria, etc.). |
| `transaction_id`   | VARCHAR(100)            | NULL                | Identificador de transacción proporcionado por el proveedor de pago (opcional).  |
| `payment_date`     | DATETIME                | NULL                | Fecha en la que se realizó el pago (opcional, útil si el pago no es inmediato).  |
| `created_at`       | DATETIME                | NOT NULL            | Fecha y hora en que se creó el registro del detalle del pago.                    |
| `modified_at`      | DATETIME                | NULL                | Fecha y hora de la última modificación del registro (opcional).                  |


### Tabla `user`
Esta tabla almacena la información de los usuarios registrados en la plataforma, incluyendo datos personales y credenciales.

| Columna       | Tipo de Dato  | Atributo                                 | Descripción                                   |
|---------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`          | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único del usuario.              |
| `username`    | VARCHAR(45)   | NOT NULL                                 | Nombre de usuario.                            |
| `password`    | VARCHAR(40)   | NOT NULL                                 | Contraseña encriptada del usuario.            |
| `first_name`  | VARCHAR(45)   | NOT NULL                                 | Nombre del usuario.                           |
| `last_name`   | VARCHAR(45)   | NOT NULL                                 | Apellido del usuario.                         |
| `address`     | VARCHAR(85)   |                                          | Dirección del usuario.                        |
| `telephone`   | VARCHAR(15)   |                                          | Teléfono del usuario.                         |
| `created_at`  | DATETIME      | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at` | DATETIME      |                                          | Fecha y hora de la última modificación.       |

### Tabla `order_items`
Esta tabla almacena los productos específicos que forman parte de un pedido, relacionando un pedido con los productos que contiene.

| Columna       | Tipo de Dato  | Atributo                                 | Descripción                                   |
|---------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`          | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único del artículo en el pedido.|
| `order_id`    | INT           | NOT NULL                                 | Clave foránea a la tabla `order_details`.     |
| `product_id`  | INT           | NOT NULL                                 | Clave foránea a la tabla `product`.           |
| `created_at`  | DATETIME      | NOT NULL                                 | Fecha y hora de creación del registro.        |
| `modified_at` | DATETIME      |                                          | Fecha y hora de la última modificación.       |

### Tabla `user_address`
Esta tabla almacena las direcciones asociadas a los usuarios, permitiendo que un usuario tenga múltiples direcciones.

| Columna        | Tipo de Dato  | Atributo                                 | Descripción                                   |
|----------------|---------------|------------------------------------------|-----------------------------------------------|
| `id`           | INT           | PRIMARY KEY, AUTO_INCREMENT, NOT NULL    | Identificador único de la dirección.          |
| `user_id`      | INT           | NOT NULL                                 | Clave foránea a la tabla `user`.              |
| `address_line1`| VARCHAR(60)   | NOT NULL                                 | Primera línea de la dirección del usuario.    |
| `address_line2`| VARCHAR(45)   |                                          | Segunda línea de la dirección (opcional).     |
| `city`         | VARCHAR(45)   | NOT NULL                                 | Ciudad de la dirección.                       |
| `postal_code`  | VARCHAR(10)   | NOT NULL                                 | Código postal de la dirección.                |
| `country`      | VARCHAR(45)   | NOT NULL                                 | País de la dirección.                         |
| `telephone`    | VARCHAR(15)   |                                          | Teléfono asociado a la dirección.             |
| `mobile`       | VARCHAR(15)  | NULL                                      | Número de móvil asociado a la dirección (opcional). |

---

## `user_payment`

**Descripción:**
La tabla `user_payment` almacena la información de los métodos de pago de los usuarios. Cada fila representa un método de pago.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY, AUTO_INCREMENT   | Identificador único del método de pago.                 |
| `user_id`      | INT          | NOT NULL                | Identificador del usuario asociado al método de pago.   |
| `payment_type` | VARCHAR(45)  | NOT NULL                | Tipo de pago (ej. tarjeta de crédito, PayPal).          |
| `provider`     | VARCHAR(45)  | NOT NULL                | Proveedor del método de pago (ej. Visa, Mastercard).    |
| `account_no`   | VARCHAR(20)  | NOT NULL                | Número de cuenta o tarjeta del método de pago.          |
| `expiry`       | CHAR(5)      | NULL                    | Fecha de vencimiento del método de pago.                |

---

## `shopping_session`

**Descripción:**
La tabla `shopping_session` gestiona las sesiones de compras activas de los usuarios. Cada fila representa una sesión de compra.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY, AUTO_INCREMENT   | Identificador único de la sesión de compra.             |
| `user_id`      | INT          | NOT NULL                | Identificador del usuario asociado a la sesión.        |
| `total`        | DECIMAL(10,2)          | NOT NULL                | Total acumulado de la sesión de compra.                 |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó la sesión de compra.        |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación de la sesión.     |

---

## `cart_item`

**Descripción:**
La tabla `cart_item` almacena los productos que los usuarios han agregado a sus carritos de compra. Cada fila representa un producto en un carrito de compra.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY, AUTO_INCREMENT   | Identificador único del ítem del carrito.               |
| `session_id`   | INT          | NOT NULL                | Identificador de la sesión de compra a la que pertenece el ítem. |
| `product_id`   | INT          | NOT NULL                | Identificador del producto en el carrito.               |
| `quantity`     | INT          | NOT NULL, UNSIGNED      | Cantidad del producto en el carrito.                    |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó el ítem del carrito.        |
| `modified_at`   | DATETIME     | NULL                | Fecha y hora en que se modifico el ítem del carrito.        |
