abstract class ProviderStructureModel<T> {
  T? data;
  void clear();
  Map? inputs;
  Future refresh();
  void goToPage([Map<String, dynamic>? inputs]);
  Future getData();
}

abstract class ProviderSelectedStructureModel<T>
    implements SelectedProviderModel<T> {
  List<T>? data;
  void clear();
  Map? inputs;
  Future refresh();
  void goToPage([Map<String, dynamic>? inputs]);
  Future getData();
}

abstract class SelectedProviderModel<T> {
  T? selectedEntity;
  bool isSelected(T entity);
  Future onSelect(T entity);
}
