enum FieldUpdateType { setDown, pickUp }

class FieldUpdate {
  final FieldUpdateType type;
  final String field;

  FieldUpdate({required this.type, required this.field});
}
