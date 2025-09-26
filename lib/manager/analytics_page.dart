import 'package:flutter/material.dart';

// Domain Models
class AnalyticsData {
  final String title;
  final String subtitle;
  final int totalItems;

  const AnalyticsData({
    required this.title,
    required this.subtitle,
    required this.totalItems,
  });
}

class ChartDataPoint {
  final String label;
  final double value;
  final Color color;
  final int count;

  const ChartDataPoint({
    required this.label,
    required this.value,
    required this.color,
    required this.count,
  });
}

class BarChartData {
  final List<double> values;
  final double maxValue;

  const BarChartData({
    required this.values,
    required this.maxValue,
  });
}

// UI Constants
class AnalyticsConstants {
  static const double cardMargin = 16.0;
  static const double cardPadding = 16.0;
  static const double sectionSpacing = 20.0;
  static const double borderRadius = 12.0;
  static const double chartHeight = 200.0;
  static const double legendItemHeight = 20.0;
}

// Theme
class AnalyticsTheme {
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Colors.white;
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color dividerColor = Color(0xFFE0E0E0);
  
  // Chart Colors
  static const Color monthlyColor = Color(0xFF00BCD4);
  static const Color weeklyColor = Color(0xFF1DB584);
  static const Color dailyColor = Color(0xFFFF7043);
  static const Color activeColor = Color(0xFF4CAF50);
  static const Color inactiveColor = Color(0xFFF44336);
  
  // Employee type colors
  static const List<Color> employeeTypeColors = [
    Color(0xFF9C27B0), // farrosh
    Color(0xFF00BCD4), // yuk tashuvchi
    Color(0xFF4CAF50), // Sotuvchi
    Color(0xFFFF9800), // Haydovchi
    Color(0xFFE91E63), // tungi qorovul
    Color(0xFF3F51B5), // Bo'lim boshliqi
    Color(0xFF795548), // qorovul
    Color(0xFF607D8B), // Kadr bo'limi
    Color(0xFF009688), // Buhgalter
  ];
}

// Analytics Repository Interface
abstract class AnalyticsRepository {
  AnalyticsData getEmployeeAttendanceData();
  List<ChartDataPoint> getEmployeeTypeData();
  BarChartData getMonthlyAttendanceChart();
  List<ChartDataPoint> getEmployeeStatusData();
  List<ChartDataPoint> getDetailedEmployeeStatusData();
}

// Analytics Repository Implementation
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  @override
  AnalyticsData getEmployeeAttendanceData() {
    return const AnalyticsData(
      title: 'Xodimlar davomati',
      subtitle: 'Sentyabr oyi uchun xodimlar davomati statistikasi bar chartda',
      totalItems: 26,
    );
  }

  @override
  List<ChartDataPoint> getEmployeeTypeData() {
    return const [
      ChartDataPoint(label: 'Oylik', value: 100, color: AnalyticsTheme.monthlyColor, count: 26),
      ChartDataPoint(label: 'Haftalik', value: 0, color: AnalyticsTheme.weeklyColor, count: 0),
      ChartDataPoint(label: 'Kunlik', value: 0, color: AnalyticsTheme.dailyColor, count: 0),
    ];
  }

  @override
  BarChartData getMonthlyAttendanceChart() {
    return const BarChartData(
      values: [0, 8, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      maxValue: 15,
    );
  }

  @override
  List<ChartDataPoint> getEmployeeStatusData() {
    return const [
      ChartDataPoint(label: 'Faol', value: 100, color: AnalyticsTheme.activeColor, count: 26),
      ChartDataPoint(label: 'Faol emas', value: 0, color: AnalyticsTheme.inactiveColor, count: 0),
    ];
  }

  @override
  List<ChartDataPoint> getDetailedEmployeeStatusData() {
    return [
      ChartDataPoint(label: 'farrosh', value: 11.5, color: AnalyticsTheme.employeeTypeColors[0], count: 3),
      ChartDataPoint(label: 'yuk tashuvchi', value: 15.4, color: AnalyticsTheme.employeeTypeColors[1], count: 4),
      ChartDataPoint(label: 'Sotuvchi', value: 38.5, color: AnalyticsTheme.employeeTypeColors[2], count: 10),
      ChartDataPoint(label: 'Haydovchi', value: 15.4, color: AnalyticsTheme.employeeTypeColors[3], count: 4),
      ChartDataPoint(label: 'tungi qorovul', value: 3.8, color: AnalyticsTheme.employeeTypeColors[4], count: 1),
      ChartDataPoint(label: 'Bo\'lim boshliqi', value: 7.7, color: AnalyticsTheme.employeeTypeColors[5], count: 2),
      ChartDataPoint(label: 'qorovul', value: 3.8, color: AnalyticsTheme.employeeTypeColors[6], count: 1),
      ChartDataPoint(label: 'Kadr bo\'limi', value: 3.8, color: AnalyticsTheme.employeeTypeColors[7], count: 1),
      ChartDataPoint(label: 'Buhgalter', value: 3.8, color: AnalyticsTheme.employeeTypeColors[8], count: 1),
    ];
  }
}

// Analytics Use Case
class AnalyticsUseCase {
  final AnalyticsRepository _repository;

  AnalyticsUseCase(this._repository);

  AnalyticsData getEmployeeAttendanceData() => _repository.getEmployeeAttendanceData();
  List<ChartDataPoint> getEmployeeTypeData() => _repository.getEmployeeTypeData();
  BarChartData getMonthlyAttendanceChart() => _repository.getMonthlyAttendanceChart();
  List<ChartDataPoint> getEmployeeStatusData() => _repository.getEmployeeStatusData();
  List<ChartDataPoint> getDetailedEmployeeStatusData() => _repository.getDetailedEmployeeStatusData();
}

// Analytics State Management
class AnalyticsState {
  final AnalyticsData employeeAttendanceData;
  final List<ChartDataPoint> employeeTypeData;
  final BarChartData monthlyChart;
  final List<ChartDataPoint> employeeStatusData;
  final List<ChartDataPoint> detailedStatusData;
  final bool isLoading;
  final String selectedMonth;
  final String selectedFilter;

  const AnalyticsState({
    required this.employeeAttendanceData,
    required this.employeeTypeData,
    required this.monthlyChart,
    required this.employeeStatusData,
    required this.detailedStatusData,
    this.isLoading = false,
    this.selectedMonth = 'Sentyabr 2025',
    this.selectedFilter = 'Keldi',
  });

  AnalyticsState copyWith({
    AnalyticsData? employeeAttendanceData,
    List<ChartDataPoint>? employeeTypeData,
    BarChartData? monthlyChart,
    List<ChartDataPoint>? employeeStatusData,
    List<ChartDataPoint>? detailedStatusData,
    bool? isLoading,
    String? selectedMonth,
    String? selectedFilter,
  }) {
    return AnalyticsState(
      employeeAttendanceData: employeeAttendanceData ?? this.employeeAttendanceData,
      employeeTypeData: employeeTypeData ?? this.employeeTypeData,
      monthlyChart: monthlyChart ?? this.monthlyChart,
      employeeStatusData: employeeStatusData ?? this.employeeStatusData,
      detailedStatusData: detailedStatusData ?? this.detailedStatusData,
      isLoading: isLoading ?? this.isLoading,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

// Analytics Controller
class AnalyticsController extends ChangeNotifier {
  final AnalyticsUseCase _useCase;
  late AnalyticsState _state;

  AnalyticsController(this._useCase) {
    _state = AnalyticsState(
      employeeAttendanceData: _useCase.getEmployeeAttendanceData(),
      employeeTypeData: _useCase.getEmployeeTypeData(),
      monthlyChart: _useCase.getMonthlyAttendanceChart(),
      employeeStatusData: _useCase.getEmployeeStatusData(),
      detailedStatusData: _useCase.getDetailedEmployeeStatusData(),
    );
  }

  AnalyticsState get state => _state;

  void updateMonth(String month) {
    _state = _state.copyWith(selectedMonth: month);
    notifyListeners();
  }

  void updateFilter(String filter) {
    _state = _state.copyWith(selectedFilter: filter);
    notifyListeners();
  }

  void refreshData() {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      _state = _state.copyWith(
        employeeAttendanceData: _useCase.getEmployeeAttendanceData(),
        employeeTypeData: _useCase.getEmployeeTypeData(),
        monthlyChart: _useCase.getMonthlyAttendanceChart(),
        employeeStatusData: _useCase.getEmployeeStatusData(),
        detailedStatusData: _useCase.getDetailedEmployeeStatusData(),
        isLoading: false,
      );
      notifyListeners();
    });
  }
}

// UI Components
class AnalyticsCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const AnalyticsCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(AnalyticsConstants.cardMargin),
      padding: padding ?? const EdgeInsets.all(AnalyticsConstants.cardPadding),
      decoration: BoxDecoration(
        color: AnalyticsTheme.cardColor,
        borderRadius: BorderRadius.circular(AnalyticsConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AnalyticsTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: AnalyticsTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class CustomBarChart extends StatelessWidget {
  final BarChartData data;

  const CustomBarChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AnalyticsConstants.chartHeight,
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        size: const Size(double.infinity, AnalyticsConstants.chartHeight - 32),
        painter: BarChartPainter(data),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final BarChartData data;
  
  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AnalyticsTheme.primaryColor
      ..style = PaintingStyle.fill;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Chart area dimensions
    const leftMargin = 30.0;
    const bottomMargin = 30.0;
    final chartWidth = size.width - leftMargin;
    final chartHeight = size.height - bottomMargin;
    
    // Draw bars
    final barWidth = chartWidth / data.values.length * 0.6;
    final barSpacing = chartWidth / data.values.length;
    
    for (int i = 0; i < data.values.length; i++) {
      final value = data.values[i];
      if (value > 0) {
        final barHeight = (value / data.maxValue) * chartHeight;
        final x = leftMargin + (i * barSpacing) + (barSpacing - barWidth) / 2;
        final y = chartHeight - barHeight;
        
        // Draw bar with rounded top
        final rect = RRect.fromRectAndCorners(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          topLeft: const Radius.circular(4),
          topRight: const Radius.circular(4),
        );
        canvas.drawRRect(rect, paint);
      }
    }

    // Draw Y-axis labels
    final yLabelPaint = Paint()..color = AnalyticsTheme.textSecondary;
    for (int i = 0; i <= data.maxValue.toInt(); i += (data.maxValue / 5).ceil()) {
      final y = chartHeight - (i / data.maxValue) * chartHeight;
      
      textPainter.text = TextSpan(
        text: i.toString(),
        style: const TextStyle(
          fontSize: 10,
          color: AnalyticsTheme.textSecondary,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // Draw X-axis labels (day numbers)
    for (int i = 0; i < data.values.length; i += 2) {
      final x = leftMargin + (i * barSpacing) + barSpacing / 2;
      final y = size.height - 15;
      
      textPainter.text = TextSpan(
        text: (i + 1).toString(),
        style: const TextStyle(
          fontSize: 10,
          color: AnalyticsTheme.textSecondary,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomPieChart extends StatelessWidget {
  final List<ChartDataPoint> data;
  final double size;

  const CustomPieChart({
    Key? key,
    required this.data,
    this.size = 140,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: PieChartPainter(data),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  
  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.2;
    
    double startAngle = -90 * (3.14159 / 180); // Start from top
    final total = data.fold<double>(0, (sum, item) => sum + item.value);
    
    for (final point in data) {
      if (point.value > 0) {
        final sweepAngle = (point.value / total) * 2 * 3.14159;
        
        final paint = Paint()
          ..color = point.color
          ..style = PaintingStyle.fill;
        
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          true,
          paint,
        );
        
        startAngle += sweepAngle;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ChartLegend extends StatelessWidget {
  final List<ChartDataPoint> data;

  const ChartLegend({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: data.map((point) => LegendItem(data: point)).toList(),
    );
  }
}

class LegendItem extends StatelessWidget {
  final ChartDataPoint data;

  const LegendItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: data.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '${data.label} (${data.count})',
          style: const TextStyle(
            fontSize: 12,
            color: AnalyticsTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class FilterHeader extends StatelessWidget {
  final String selectedMonth;
  final String selectedFilter;
  final VoidCallback onMonthTap;
  final VoidCallback onFilterTap;
  final VoidCallback onExportTap;

  const FilterHeader({
    Key? key,
    required this.selectedMonth,
    required this.selectedFilter,
    required this.onMonthTap,
    required this.onFilterTap,
    required this.onExportTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildFilterButton(selectedMonth, onMonthTap, Icons.calendar_today),
        const SizedBox(width: 8),
        _buildFilterButton(selectedFilter, onFilterTap, Icons.keyboard_arrow_down),
        const Spacer(),
        _buildExportButton(),
      ],
    );
  }

  Widget _buildFilterButton(String text, VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AnalyticsTheme.dividerColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon == Icons.calendar_today)
              Icon(icon, size: 16, color: AnalyticsTheme.textSecondary),
            if (icon == Icons.calendar_today) const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AnalyticsTheme.textPrimary,
              ),
            ),
            if (icon != Icons.calendar_today) const SizedBox(width: 4),
            if (icon != Icons.calendar_today)
              Icon(icon, size: 16, color: AnalyticsTheme.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return InkWell(
      onTap: onExportTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AnalyticsTheme.activeColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.file_upload_outlined, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'Excelga yuqlab olish',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main Analytics Page
class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late AnalyticsController _controller;

  @override
  void initState() {
    super.initState();
    final repository = AnalyticsRepositoryImpl();
    final useCase = AnalyticsUseCase(repository);
    _controller = AnalyticsController(useCase);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tahlillar paneli',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AnalyticsTheme.textPrimary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Filter Header
                AnalyticsCard(
                  child: FilterHeader(
                    selectedMonth: _controller.state.selectedMonth,
                    selectedFilter: _controller.state.selectedFilter,
                    onMonthTap: _showMonthPicker,
                    onFilterTap: _showFilterPicker,
                    onExportTap: _handleExport,
                  ),
                ),

                // Employee Attendance Chart
                AnalyticsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: _controller.state.employeeAttendanceData.title,
                        subtitle: _controller.state.employeeAttendanceData.subtitle,
                      ),
                      const SizedBox(height: 20),
                      CustomBarChart(data: _controller.state.monthlyChart),
                    ],
                  ),
                ),

                // Employee Types
                AnalyticsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Xodimlar turi',
                        subtitle: 'Xodimlar turi statistikasi pizza chartda\n${_controller.state.employeeAttendanceData.totalItems} ta xodim',
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomPieChart(data: _controller.state.employeeTypeData),
                      ),
                      const SizedBox(height: 16),
                      ChartLegend(data: _controller.state.employeeTypeData),
                    ],
                  ),
                ),

                // Detailed Employee Types
                AnalyticsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Xodim ro\'li',
                        subtitle: '${_controller.state.employeeAttendanceData.totalItems} ta xodim',
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomPieChart(
                          data: _controller.state.detailedStatusData,
                          size: 160,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ChartLegend(data: _controller.state.detailedStatusData),
                    ],
                  ),
                ),

                // Employee Status
                AnalyticsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Xodim ro\'li',
                        subtitle: '${_controller.state.employeeAttendanceData.totalItems} ta xodim',
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomPieChart(data: _controller.state.employeeStatusData),
                      ),
                      const SizedBox(height: 16),
                      ChartLegend(data: _controller.state.employeeStatusData),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Select Month', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  'Sentyabr 2025',
                  'Avgust 2025',
                  'Iyul 2025',
                ].map((month) => ListTile(
                  title: Text(month),
                  onTap: () {
                    _controller.updateMonth(month);
                    Navigator.pop(context);
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Select Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  'Keldi',
                  'Kelmadi',
                ].map((filter) => ListTile(
                  title: Text(filter),
                  onTap: () {
                    _controller.updateFilter(filter);
                    Navigator.pop(context);
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleExport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting to Excel...')),
    );
  }
}