class OrderState {
  const OrderState({
    this.id,
    this.name,
    this.description,
    this.selected = false,
  });

  final int id;
  final String name;
  final String description;
  final bool selected;

  OrderState copyWith({
    int id,
    String name,
    String description,
    bool selected,
  }) =>
      OrderState(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        selected: selected ?? this.selected,
      );
}
