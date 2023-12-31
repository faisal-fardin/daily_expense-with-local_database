const String tblCategory = 'tbl_category';
const String tblCategoryColID = 'id';
const String tblCategoryColName = 'name';

class CategoryModels {
  int? id;
  String name;

  CategoryModels(this.name, {this.id});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblCategoryColName: name,
    };
    if (id != null) {
      map[tblCategoryColID] = id;
    }
    return map;
  }

  factory CategoryModels.fromMap(Map<String, dynamic> map) => CategoryModels(
        map[tblCategoryColName],
        id: map[tblCategoryColID],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModels &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

}
