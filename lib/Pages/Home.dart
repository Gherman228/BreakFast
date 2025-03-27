import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/models/category_model.dart';
import 'package:money_management/models/diet_model.dart';
import 'package:money_management/models/popular_model_art.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  void _getInitialInfo() {
    setState(() {
      categories = CategoryModel.getCategories();
      diets = DietModel.getDiets();
      popularDiets = PopularDietsModel.getPopularDiets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: [
            _searchField(),
            const SizedBox(height: 40),
            _categoriesSection(),
            const SizedBox(height: 40),
            _dietsSection(),
            const SizedBox(height: 40),
            _popularDietsSection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'BreakFast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: _buildIconButton('assets/icons/back_arow.svg', () {}),
      actions: [_buildIconButton('assets/icons/dots.svg', () {})],
    );
  }

  Widget _buildIconButton(String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 37,
        decoration: BoxDecoration(
          color: const Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(iconPath, height: 20, width: 20),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search Pancake',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset('assets/icons/lupa.svg'),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _categoriesSection() {
    return _buildSection(
      title: 'Category',
      child: SizedBox(
        height: 120,
        child: ListView.separated(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          separatorBuilder: (_, __) => const SizedBox(width: 25),
          itemBuilder: (context, index) => _buildCategoryItem(index),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: categories[index].boxColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCategoryIcon(index),
          _buildCategoryName(index),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(categories[index].iconPath),
      ),
    );
  }

  Widget _buildCategoryName(int index) {
    return Text(
      categories[index].name,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }

  Widget _dietsSection() {
    return _buildSection(
      title: 'Recommendation for Diets',
      child: SizedBox(
        height: 240,
        child: ListView.separated(
          itemCount: diets.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          separatorBuilder: (_, __) => const SizedBox(width: 25),
          itemBuilder: (context, index) => _buildDietItem(index),
        ),
      ),
    );
  }

  Widget _buildDietItem(int index) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: categories[index % categories.length].boxColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDietIcon(index),
          _buildDietName(index),
          _buildDietDetails(index),
          _buildDietAction(index),
        ],
      ),
    );
  }

  Widget _buildDietIcon(int index) {
    return SvgPicture.asset(
      diets[index].iconPath,
      width: 80,
      height: 80,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => const CircularProgressIndicator(),
    );
  }

  Widget _buildDietName(int index) {
    return Text(
      diets[index].name,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  Widget _buildDietDetails(int index) {
    return Text(
      "${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}",
      style: const TextStyle(
        color: Color(0xff7B6F72),
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildDietAction(int index) {
    return Container(
      height: 45,
      width: 130,
      child: Center(
        child: Text(
          'View',
          style: TextStyle(
            color: diets[index].viewIsSelected ? Colors.white : const Color(0xff9DCEFF),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            diets[index].viewIsSelected ? const Color(0xff9DCEFF) : Colors.transparent,
            diets[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  Widget _popularDietsSection() {
    return _buildSection(
      title: 'Popular',
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 25),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: popularDiets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildPopularDietItem(index),
      ),
    );
  }

  Widget _buildPopularDietItem(int index) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            popularDiets[index].iconPath,
            width: 65,
            height: 65,
          ),
          _buildPopularDietDetails(index),
          _buildArrowIcon(),
        ],
      ),
      decoration: BoxDecoration(
        color: popularDiets[index].boxIsSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: popularDiets[index].boxIsSelected
            ? [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.07),
            offset: const Offset(0, 10),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ]
            : [],
      ),
    );
  }

  Widget _buildPopularDietDetails(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          popularDiets[index].name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}",
          style: const TextStyle(
            color: Color(0xff7B6F72),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildArrowIcon() {
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(
        'assets/icons/arrow_stanga.svg',
        width: 30,
        height: 30,
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        child,
      ],
    );
  }
}
