import 'package:flutter/material.dart';
import '../config/ui_constants.dart';

/// Column definition for StyledDataTable.
class StyledColumn {
  final String label;
  final int flex;

  const StyledColumn({required this.label, this.flex = 1});
}

/// Row definition for StyledDataTable.
class StyledRow {
  final List<Widget> cells;
  final bool selected;
  final VoidCallback? onTap;

  const StyledRow({required this.cells, this.selected = false, this.onTap});
}

/// Centralized styled data grid widget.
/// - Always fills available width and height
/// - Fixed header, vertically scrollable body with visible scrollbar
/// - Built-in client-side or server-side pagination
class StyledDataTable extends StatefulWidget {
  final bool isDarkTheme;
  final List<StyledColumn> columns;
  final List<StyledRow> rows;
  final bool showCheckboxColumn;

  /// Rows per page for client-side pagination.
  final int rowsPerPage;

  /// Called when the page changes (for server-side pagination).
  final void Function(int page)? onPageChanged;

  /// Called when the page size changes (for server-side pagination).
  final void Function(int pageSize)? onPageSizeChanged;

  /// Total number of pages (for server-side pagination).
  final int? totalPages;

  /// Current page (for server-side pagination, 1-based).
  final int? currentPage;

  /// Minimum width per flex unit. When total columns * minColumnWidth exceeds
  /// available width, horizontal scrolling is enabled automatically.
  /// Default is 80.
  final double minColumnWidth;

  const StyledDataTable({
    super.key,
    required this.isDarkTheme,
    required this.columns,
    required this.rows,
    this.showCheckboxColumn = false,
    this.rowsPerPage = 20,
    this.onPageChanged,
    this.onPageSizeChanged,
    this.minColumnWidth = 80,
    this.totalPages,
    this.currentPage,
  });

  /// Standard header text style for all grids.
  static TextStyle headerStyle(bool isDarkTheme) => TextStyle(
        color: UIConstants.textSecondary(isDarkTheme),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );

  /// Standard cell text style for all grids.
  static TextStyle cellStyle(bool isDarkTheme) => TextStyle(
        color: UIConstants.textPrimary(isDarkTheme),
        fontSize: UIConstants.fontSizeSm,
      );

  @override
  State<StyledDataTable> createState() => _StyledDataTableState();
}

class _StyledDataTableState extends State<StyledDataTable> {
  int _internalPage = 1;
  final _scrollController = ScrollController();

  int get _currentPage => widget.currentPage ?? _internalPage;

  bool get _isServerSidePagination => widget.onPageChanged != null;

  int get _totalPages {
    if (widget.totalPages != null) return widget.totalPages!;
    if (widget.rowsPerPage <= 0) return 1;
    final total = (widget.rows.length / widget.rowsPerPage).ceil();
    return total > 0 ? total : 1;
  }

  List<StyledRow> get _pagedRows {
    if (_isServerSidePagination) return widget.rows;
    if (widget.rowsPerPage <= 0) return widget.rows;

    final start = (_currentPage - 1) * widget.rowsPerPage;
    final end = (start + widget.rowsPerPage).clamp(0, widget.rows.length);
    if (start >= widget.rows.length) return [];
    return widget.rows.sublist(start, end);
  }

  bool get _needsPagination => _totalPages > 1;

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    if (_isServerSidePagination) {
      widget.onPageChanged!(page);
    } else {
      setState(() => _internalPage = page);
    }
  }

  final _hScrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _hScrollController.dispose();
    super.dispose();
  }

  /// Calculate the minimum total width needed based on column flex and minColumnWidth.
  double _calcMinWidth() {
    int totalFlex = 0;
    for (final col in widget.columns) {
      totalFlex += col.flex;
    }
    return totalFlex * widget.minColumnWidth + 32; // 32 for horizontal padding
  }

  Widget _buildRow(List<Widget> cells, {bool isHeader = false}) {
    return Row(
      children: List.generate(
        cells.length,
        (i) => Expanded(
          flex: i < widget.columns.length ? widget.columns[i].flex : 1,
          child: Center(child: cells[i]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkTheme;
    final bgColor = UIConstants.tableRowEven(isDark);
    final borderColor = UIConstants.borderColor(isDark);
    final pagedRows = _pagedRows;

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final minWidth = _calcMinWidth();
              final needsHScroll = minWidth > constraints.maxWidth;
              final contentWidth = needsHScroll ? minWidth : constraints.maxWidth;

              Widget tableContent = Container(
                width: contentWidth,
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Fixed header
                    Container(
                      color: UIConstants.tableHeaderBackground(isDark),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: _buildRow(
                        widget.columns.map((col) => Text(
                          col.label,
                          style: StyledDataTable.headerStyle(isDark),
                          overflow: TextOverflow.ellipsis,
                        )).toList().cast<Widget>(),
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: borderColor),
                    // Scrollable body
                    Expanded(
                      child: pagedRows.isEmpty
                          ? const SizedBox.expand()
                          : Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              thickness: 8,
                              radius: const Radius.circular(4),
                              child: ListView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: pagedRows.length,
                                itemBuilder: (context, index) {
                                  final row = pagedRows[index];
                                  final rowBg = index % 2 == 0
                                      ? UIConstants.tableRowEven(isDark)
                                      : UIConstants.tableRowOdd(isDark);
                                  return InkWell(
                                    onTap: row.onTap,
                                    child: Container(
                                      color: rowBg,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 3),
                                      child: _buildRow(row.cells),
                                    ),
                                  );
                                },
                          ),
                        ),
                ),
              ],
            ),
          );

              if (needsHScroll) {
                return Scrollbar(
                  controller: _hScrollController,
                  thumbVisibility: true,
                  notificationPredicate: (n) => n.depth == 0,
                  child: SingleChildScrollView(
                    controller: _hScrollController,
                    scrollDirection: Axis.horizontal,
                    child: tableContent,
                  ),
                );
              }

              return tableContent;
            },
          ),
        ),
        if (_needsPagination) _buildPaginationControls(),
      ],
    );
  }

  void _changePageSize(int newSize) {
    if (_isServerSidePagination) {
      widget.onPageSizeChanged?.call(newSize);
    } else {
      setState(() => _internalPage = 1);
    }
  }

  Widget _buildPaginationControls() {
    final isDark = widget.isDarkTheme;
    final textColor = UIConstants.textPrimary(isDark);

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.first_page, color: textColor, size: 18),
            onPressed: _currentPage > 1 ? () => _goToPage(1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            icon: Icon(Icons.chevron_left, color: textColor, size: 18),
            onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          Text(
            'Page $_currentPage of $_totalPages',
            style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: textColor, size: 18),
            onPressed: _currentPage < _totalPages ? () => _goToPage(_currentPage + 1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            icon: Icon(Icons.last_page, color: textColor, size: 18),
            onPressed: _currentPage < _totalPages ? () => _goToPage(_totalPages) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            height: UIConstants.buttonHeightStandard * 0.7,
            child: DropdownButtonFormField<int>(
              value: widget.rowsPerPage,
              isDense: true,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                  borderSide: BorderSide(color: UIConstants.borderColor(isDark)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                isDense: true,
              ),
              style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm),
              dropdownColor: UIConstants.dropdownBackground(isDark),
              items: [10, 20, 50, 100]
                  .map((size) => DropdownMenuItem(
                        value: size,
                        child: Text('$size', style: TextStyle(color: textColor, fontSize: UIConstants.fontSizeSm)),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) _changePageSize(value);
              },
            ),
          ),
          Text(
            ' / page',
            style: TextStyle(color: UIConstants.textSecondary(isDark), fontSize: UIConstants.fontSizeSm),
          ),
        ],
      ),
    );
  }
}
