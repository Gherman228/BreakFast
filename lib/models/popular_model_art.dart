class PopularDietsModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool boxIsSelected;

  PopularDietsModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxIsSelected
  });

  static List<PopularDietsModel> getPopularDiets() {
    List<PopularDietsModel> popularDiets = [];

    popularDiets.add(
        PopularDietsModel(
            name: 'Ramen',
            iconPath: 'assets/icons/ramen.svg',
            level: 'Medium',
            duration: '45 min',
            calorie: '65kCal',
            boxIsSelected: true
        )
    );

    popularDiets.add(
        PopularDietsModel(
            name: 'Guacamole',
            iconPath: 'assets/icons/guacamole.svg',
            level: 'Easy',
            duration: '25 min',
            calorie: '275kCal',
            boxIsSelected: true
        )
    );

    return popularDiets;
  }
}

