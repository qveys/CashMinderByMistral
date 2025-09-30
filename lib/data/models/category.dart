class Category {
  final String id;
  final String name;
  final String icon; // Optionnel : pour afficher une icône

  Category({
    required this.id,
    required this.name,
    this.icon = 'default',
  });
}