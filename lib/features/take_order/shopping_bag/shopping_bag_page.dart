import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/take_order/shopping_bag/shopping_bag_view_model.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ShoppingBagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingBagViewModel()),
      ],
      child: LoadingOverlay<ShoppingBagViewModel>(
        child: ShoppingBagPageBase(),
      ),
    );
  }
}

class ShoppingBagPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ShoppingBagViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(headerTitle: 'Bolsa de Pedidos'),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
            color: AmadisColors.backgroundColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: wp(2)),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _viewModel.orderService.getOrders,
                  child: StreamBuilder(
                    stream: _viewModel.productPresentationList,
                    builder:
                        (_, AsyncSnapshot<List<ProductPresentation>> snapshot) {
                      if (snapshot.hasData) {
                        print('objerct');
                        final presentation = snapshot.data;
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: hp(5)),
                          physics: BouncingScrollPhysics(),
                          itemCount: presentation.length,
                          itemBuilder: (context, index) {
                            final productPresentation = presentation[index];
                            return ProductContainer(
                              productPresentation: productPresentation,
                            );
                          },
                          separatorBuilder: (_, __) => Divider(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(2)),
                child: CustomButton(
                  onPressed: _viewModel.orderDetail.isNotEmpty
                      ? _viewModel.addProducts
                      : null,
                  text: 'AGREGAR PRODUCTOS',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    Key key,
    @required this.productPresentation,
  }) : super(key: key);

  final ProductPresentation productPresentation;

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ShoppingBagViewModel>(context);
    return Container(
      height: hp(10),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: FadeInImage.assetNetwork(
              fit: BoxFit.contain,
              placeholder:
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shopify.co.id%2Fpartners%2Fblog%2Fplaceholder-images&psig=AOvVaw3bXzQ9iM_wOm6J7NOqRVbT&ust=1609137004378000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPDQ2s_E7e0CFQAAAAAdAAAAABAD',
              image: '${productPresentation.imageUrl}',
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${productPresentation.product.name}\n${productPresentation.presentation.name}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'S/. ${productPresentation.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          _viewModel.handleRemoveQuantity(productPresentation),
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Center(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: _viewModel
                              .getQuantity(productPresentation)
                              .toString(),
                        )..selection = TextSelection.collapsed(
                            offset: _viewModel
                                .getQuantity(productPresentation)
                                .toString()
                                .length,
                          ),
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLengthEnforced: true,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.subtitle1,
                        onChanged: (value) => _viewModel.handleEditQuantity(
                            productPresentation, value),
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: '',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      padding: EdgeInsets.zero,
                      onPressed: () => _viewModel
                          .handleAddDetailQuantity(productPresentation),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
