// MODELS
import 'package:amadis_delivery/models/category.dart';
import 'package:amadis_delivery/models/order_state.dart';
import 'package:amadis_delivery/models/order_type.dart';
import 'package:amadis_delivery/models/presentation.dart';
import 'package:amadis_delivery/models/product.dart';
import 'package:amadis_delivery/models/product_presentation.dart';

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
  OrderState(
      id: 1,
      name: 'Confirmados',
      description: 'Orden confirmada.',
      selected: true),
  OrderState(
    id: 2,
    name: 'Cancelados',
    description: 'Orden cancelada.',
    selected: false,
  ),
  OrderState(
    id: 3,
    name: 'Preparados',
    description: 'Orden preparada para su envío.',
    selected: false,
  ),
  OrderState(
    id: 4,
    name: 'En ruta',
    description: 'Orden en ruta.',
    selected: false,
  ),
  OrderState(
    id: 5,
    name: 'Arribados',
    description: 'Orden arribada al destino.',
    selected: false,
  ),
  OrderState(
    id: 6,
    name: 'Cotizados',
    description: 'Orden cotizada.',
    selected: false,
  ),
  OrderState(
    id: 7,
    name: 'Completados',
    description: 'Orden completada.',
    selected: false,
  ),
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

final productsPresentation = <ProductPresentation>[
  ProductPresentation(
    id: 1,
    price: 50.00,
    product: products.first,
    presentation: Presentation(
      id: 1,
      name: '650 ml',
      description: 'Presentación de 650 ml',
    ),
  ),
  ProductPresentation(
    id: 2,
    price: 60.00,
    product: products[1],
    presentation: presentations.first,
  ),
  ProductPresentation(
    id: 3,
    price: 55.00,
    product: products[2],
    presentation: presentations.first,
  ),
  ProductPresentation(
    id: 4,
    price: 62.00,
    product: products[3],
    presentation: presentations.first,
  ),
];

final presentations = <Presentation>[
  Presentation(
    id: 1,
    name: '650 ml',
    description: 'Presentación de 650 ml',
  ),
];

final products = <Product>[
  Product(
    id: 1,
    name: 'Cristal',
    description: 'Cerveza Cristal',
    category: categories.first,
  ),
  Product(
    id: 2,
    name: 'Pilsen Callao',
    description: 'Cerveza Pilsen Callao',
    category: categories.first,
  ),
  Product(
    id: 3,
    name: 'Cusqueña Dorada',
    description: 'Cerveza Cusqueña Blanca',
    category: categories.first,
  ),
  Product(
    id: 4,
    name: 'Cusqueña Negra',
    description: 'Cerveza Cuzqueña Negra',
    category: categories.first,
  ),
];
