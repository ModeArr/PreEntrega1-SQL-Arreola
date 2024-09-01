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

## Modelo de negocio
1. **Registrar usuarios y guardar su datos**: Necesitamos que la base de datos guarde usuarios y sus datos como son direcciones y métodos de pagos, esto para dar una experiencia mejorada al usuario.

2. **Gestión de productos**: Es importante tener un sistema que permita guardar los productos asi como manejar su inventario y categorías. Asi también se necesita tener un control de los descuentos.

3. **Compra mediante un carrito de compras**: La base de datos debe permitirnos hacer la compra de productos mediante un carrito de compras y poder registrar las sesiones de compras de cada carrito para tener un control de marketing de donde y cuando se quedan en el proceso de compras.

4. **Registro de ventas**: Necesitamos un sistema que pueda registrar de manera detallada cada compra hecha y todos sus detalles y que esta sea fácil para el departamento de ventas poder verificarla a fondo.

## Diagrama entidad relación (DER)
![ecomerce diagram](https://github.com/user-attachments/assets/d28309dd-c9c1-418d-97d4-f33417a3dcff)

## Listado de tablas y descripción
## `product_inventory`

**Descripción:**
La tabla `product_inventory` gestiona la cantidad de productos disponibles en el inventario. Cada fila representa un registro de inventario para un producto específico.

| Columna        | Tipo     | Atributos               | Descripción                                              |
|----------------|----------|-------------------------|----------------------------------------------------------|
| `id`            | INT      | NOT NULL, PRIMARY KEY   | Identificador único del inventario del producto.        |
| `quantity`      | INT      | NOT NULL                | Cantidad de unidades disponibles en el inventario.      |
| `created_at`    | DATETIME | NOT NULL                | Fecha y hora en que se creó el registro de inventario.  |
| `modified_at`   | DATETIME | NULL                    | Fecha y hora de la última modificación del registro.     |
| `deleted_at`    | DATETIME | NULL                    | Fecha y hora en que se eliminó el registro, si aplica.  |

---

## `discount`

**Descripción:**
La tabla `discount` almacena información sobre los descuentos aplicables en productos. Cada fila representa un tipo de descuento que puede ser aplicado a productos.

| Columna              | Tipo         | Atributos               | Descripción                                              |
|-----------------------|--------------|-------------------------|----------------------------------------------------------|
| `id`                  | INT          | NOT NULL, PRIMARY KEY   | Identificador único del descuento.                      |
| `name`                | VARCHAR(80)  | NOT NULL                | Nombre del descuento.                                  |
| `description`         | VARCHAR(120) | NULL                    | Descripción del descuento.                             |
| `discount_percent`    | INT          | NOT NULL                | Porcentaje de descuento aplicado.                      |
| `active`              | TINYINT(1)   | NOT NULL, DEFAULT 0     | Indicador de si el descuento está activo (1) o no (0).  |
| `created_at`          | DATETIME     | NOT NULL                | Fecha y hora en que se creó el descuento.              |
| `modified_at`         | DATETIME     | NULL                    | Fecha y hora de la última modificación del descuento.   |
| `deleted_at`          | DATETIME     | NULL                    | Fecha y hora en que se eliminó el descuento, si aplica. |

---

## `product_category`

**Descripción:**
La tabla `product_category` organiza los productos en diferentes categorías. Cada fila representa una categoría de productos.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único de la categoría de producto.        |
| `name`         | VARCHAR(80)  | NOT NULL                | Nombre de la categoría.                                |
| `description`  | VARCHAR(180) | NULL                    | Descripción de la categoría.                           |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó la categoría.              |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación de la categoría. |
| `deleted_at`   | DATETIME     | NULL                    | Fecha y hora en que se eliminó la categoría, si aplica. |

---

## `product`

**Descripción:**
La tabla `product` almacena información sobre los productos disponibles para la venta. Cada fila representa un producto.

| Columna          | Tipo         | Atributos               | Descripción                                              |
|------------------|--------------|-------------------------|----------------------------------------------------------|
| `id`              | INT          | NOT NULL, PRIMARY KEY   | Identificador único del producto.                        |
| `name`            | VARCHAR(100) | NOT NULL                | Nombre del producto.                                    |
| `description`     | VARCHAR(300) | NULL                    | Descripción del producto.                               |
| `SKU`             | VARCHAR(50)  | NOT NULL                | Código único del producto (Stock Keeping Unit).         |
| `category_id`     | INT          | NOT NULL                | Identificador de la categoría a la que pertenece el producto. |
| `inventory_id`    | INT          | NOT NULL                | Identificador del inventario del producto.               |
| `price`           | DECIMAL(6)   | NOT NULL                | Precio del producto.                                    |
| `discount_id`     | INT          | NOT NULL, DEFAULT 0     | Identificador del descuento aplicado al producto.        |
| `created_at`      | DATETIME     | NOT NULL                | Fecha y hora en que se creó el producto.                |
| `modified_at`     | DATETIME     | NULL                    | Fecha y hora de la última modificación del producto.     |
| `deleted_at`      | DATETIME     | NULL                    | Fecha y hora en que se eliminó el producto, si aplica.   |

---

## `payment_details`

**Descripción:**
La tabla `payment_details` gestiona la información de los pagos realizados. Cada fila representa un pago asociado a un pedido.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único del detalle de pago.                |
| `order_id`     | INT          | NOT NULL                | Identificador del pedido asociado al pago.              |
| `amount`       | INT          | NOT NULL                | Monto del pago realizado.                               |
| `provider`     | VARCHAR(45)  | NOT NULL                | Proveedor del servicio de pago.                         |
| `status`       | VARCHAR(45)  | NOT NULL                | Estado del pago (ej. completado, pendiente).             |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó el registro del pago.       |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación del pago.        |

---

## `user`

**Descripción:**
La tabla `user` almacena información sobre los usuarios registrados en el sistema. Cada fila representa un usuario.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único del usuario.                        |
| `username`     | VARCHAR(45)  | NOT NULL                | Nombre de usuario.                                      |
| `password`     | VARCHAR(40)  | NOT NULL                | Contraseña del usuario (generalmente almacenada en forma cifrada). |
| `first_name`   | VARCHAR(45)  | NOT NULL                | Nombre del usuario.                                     |
| `last_name`    | VARCHAR(45)  | NOT NULL                | Apellido del usuario.                                  |
| `address`      | VARCHAR(85)  | NULL                    | Dirección del usuario.                                 |
| `telephone`    | INT          | NULL                    | Número de teléfono del usuario.                         |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó el usuario.                 |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación del usuario.      |

---

## `order_details`

**Descripción:**
La tabla `order_details` guarda información sobre los pedidos realizados por los usuarios. Cada fila representa un pedido.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único del pedido.                         |
| `user_id`      | INT          | NOT NULL                | Identificador del usuario que realizó el pedido.        |
| `total`        | INT          | NOT NULL                | Total del pedido.                                       |
| `payment_id`   | INT          | NOT NULL                | Identificador del detalle de pago asociado al pedido.   |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó el pedido.                  |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación del pedido.       |

---

## `order_items`

**Descripción:**
La tabla `order_items` gestiona los productos incluidos en cada pedido. Cada fila representa un producto en un pedido.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único del ítem del pedido.                |
| `order_id`     | INT          | NOT NULL                | Identificador del pedido al que pertenece el ítem.      |
| `product_id`   | INT          | NOT NULL                | Identificador del producto en el pedido.                |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó el ítem del pedido.         |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación del ítem.        |

---

## `user_address`

**Descripción:**
La tabla `user_address` almacena las direcciones de los usuarios. Cada fila representa una dirección asociada a un usuario.

| Columna           | Tipo         | Atributos               | Descripción                                              |
|-------------------|--------------|-------------------------|----------------------------------------------------------|
| `id`              | INT          | NOT NULL, PRIMARY KEY   | Identificador único de la dirección.                    |
| `user_id`         | INT          | NOT NULL                | Identificador del usuario al que pertenece la dirección. |
| `address_line1`   | VARCHAR(80)  | NOT NULL                | Línea 1 de la dirección.                                |
| `address_line2`   | VARCHAR(80)  | NULL                    | Línea 2 de la dirección (opcional).                      |
| `city`            | VARCHAR(45)  | NOT NULL                | Ciudad de la dirección.                                |
| `postal_code`     | VARCHAR(20)  | NOT NULL                | Código postal de la dirección.                          |
| `country`         | VARCHAR(45)  | NOT NULL                | País de la dirección.                                  |
| `telephone`       | VARCHAR(20)  | NULL                    | Número de teléfono asociado a la dirección (opcional).   |
| `mobile`          | VARCHAR(20)  | NULL                    | Número de móvil asociado a la dirección (opcional).      |

---

## `user_payment`

**Descripción:**
La tabla `user_payment` almacena la información de los métodos de pago de los usuarios. Cada fila representa un método de pago.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único del método de pago.                 |
| `user_id`      | INT          | NOT NULL                | Identificador del usuario asociado al método de pago.   |
| `payment_type` | VARCHAR(45)  | NOT NULL                | Tipo de pago (ej. tarjeta de crédito, PayPal).          |
| `provider`     | VARCHAR(45)  | NOT NULL                | Proveedor del método de pago (ej. Visa, Mastercard).     |
| `account_no`   | VARCHAR(45)  | NOT NULL                | Número de cuenta o tarjeta del método de pago.          |
| `expiry`       | DATE         | NULL                    | Fecha de vencimiento del método de pago.                |

---

## `shopping_session`

**Descripción:**
La tabla `shopping_session` gestiona las sesiones de compras activas de los usuarios. Cada fila representa una sesión de compra.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único de la sesión de compra.             |
| `user_id`      | INT          | NOT NULL                | Identificador del usuario asociado a la sesión.        |
| `total`        | INT          | NOT NULL                | Total acumulado de la sesión de compra.                 |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó la sesión de compra.        |
| `modified_at`  | DATETIME     | NULL                    | Fecha y hora de la última modificación de la sesión.     |

---

## `cart_item`

**Descripción:**
La tabla `cart_item` almacena los productos que los usuarios han agregado a sus carritos de compra. Cada fila representa un producto en un carrito de compra.

| Columna       | Tipo         | Atributos               | Descripción                                              |
|---------------|--------------|-------------------------|----------------------------------------------------------|
| `id`           | INT          | NOT NULL, PRIMARY KEY   | Identificador único del ítem del carrito.               |
| `session_id`   | INT          | NOT NULL                | Identificador de la sesión de compra a la que pertenece el ítem. |
| `product_id`   | INT          | NOT NULL                | Identificador del producto en el carrito.               |
| `quantity`     | INT          | NOT NULL                | Cantidad del producto en el carrito.                    |
| `created_at`   | DATETIME     | NOT NULL                | Fecha y hora en que se creó el ítem del carrito.        |

