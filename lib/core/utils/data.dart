// MODELS
import 'package:amadis_delivery/models/category.dart';
import 'package:amadis_delivery/models/order_state.dart';
import 'package:amadis_delivery/models/order_type.dart';
import 'package:amadis_delivery/models/product.dart';

const orderTypes = <OrderType>[
  OrderType(
    id: 1,
    name: 'Pedido al contado',
    description: 'Pedido al contado.',
  ),
  OrderType(
    id: 2,
    name: 'Pedido por consignación',
    description: 'Pedido por consignación.',
  ),
];

const orderStates = <OrderState>[
  OrderState(id: 1, name: 'Confirmada', description: 'Orden confirmada.'),
  OrderState(id: 2, name: 'Cancelada', description: 'Orden cancelada.'),
  OrderState(
      id: 3, name: 'Preparada', description: 'Orden preparada para su envío.'),
  OrderState(id: 4, name: 'En ruta', description: 'Orden en ruta.'),
  OrderState(
      id: 5, name: 'Arribada', description: 'Orden arribada al destino.'),
  OrderState(id: 6, name: 'Cotizada', description: 'Orden cotizada.'),
  OrderState(id: 7, name: 'Completada', description: 'Orden completada.'),
];

const categories = <Category>[
  Category(
    id: 1,
    name: 'Cerveza',
    description: 'Bebida alcoholica.',
  ),
  Category(
    id: 2,
    name: 'Agua',
    description: 'Agua mineral y de mesa.',
  ),
  Category(
    id: 3,
    name: 'Gaseosa',
    description: 'Gaseosa y refresco.',
  ),
];

final products = <Product>[
  Product(
    id: 1,
    name: 'Cristal',
    price: 52.53,
    description: 'Cerveza Cristal',
    category: categories.singleWhere((c) => c.id == 1),
  ),
  Product(
    id: 2,
    name: 'Pilsen Callao',
    price: 57.95,
    description: 'Cerveza Pilsen Callao',
    category: categories.singleWhere((c) => c.id == 1),
  ),
  Product(
    id: 3,
    name: 'Cusqueña',
    price: 62.94,
    description: 'Cerveza Cuzqueña',
    category: categories.singleWhere((c) => c.id == 1),
  ),
];
