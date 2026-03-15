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

  /// Total number of pages (for server-side pagination).
  final int? totalPages;

  /// Current page (for server-side pagination, 1-based).
  final int? currentPage;

  const StyledDataTable({
    super.key,
    required this.isDarkTheme,
    required this.columns,
    required this.rows,
    this.showCheckboxColumn = false,
    this.rowsPerPage = 20,
    this.onPageChanged,
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          child: Container(
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
                  child: Row(
                    children: widget.columns.map((col) {
                      return Expanded(
                        flex: col.flex,
                        child: Text(
                          col.label,
                          style: StyledDataTable.headerStyle(isDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
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
                          child: ListView.builder(
                            controller: _scrollController,
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
                                  child: Row(
                                    children: List.generate(
                                      row.cells.length,
                                      (i) => Expanded(
                                        flex: i < widget.columns.length
                                            ? widget.columns[i].flex
                                            : 1,
                                        child: row.cells[i],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        if (_needsPagination) _buildPaginationControls(),
      ],
    );
  }

  Widget _buildPaginationControls() {
    final isDark = widget.isDarkTheme;
    final textColor = UIConstants.textPrimary(isDark);

    List<Widget> pageButtons = [];

    pageButtons.add(_pageButton(
      icon: Icons.chevron_left,
      enabled: _currentPage > 1,
      onTap: () => _goToPage(_currentPage - 1),
      isDark: isDark,
    ));

    for (int i = 1; i <= _totalPages; i++) {
      if (i == 1 ||
          i == _totalPages ||
          (i >= _currentPage - 1 && i <= _currentPage + 1)) {
        pageButtons.add(
          InkWell(
            onTap: () => _goToPage(i),
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i == _currentPage
                    ? Colors.blue
                    : UIConstants.visibleBorderColor(isDark),
                borderRadius:
                    BorderRadius.circular(UIConstants.textFieldBorderRadius),
              ),
              child: Center(
                child: Text(
                  i.toString(),
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeSm,
                    color: i == _currentPage ? Colors.white : textColor,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (i == _currentPage - 2 || i == _currentPage + 2) {
        pageButtons.add(
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: Center(
              child: Text(
                '...',
                style: TextStyle(
                  fontSize: UIConstants.fontSizeSm,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ),
        );
      }
    }

    pageButtons.add(_pageButton(
      icon: Icons.chevron_right,
      enabled: _currentPage < _totalPages,
      onTap: () => _goToPage(_currentPage + 1),
      isDark: isDark,
    ));

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageButtons,
      ),
    );
  }

  Widget _pageButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: enabled
              ? UIConstants.visibleBorderColor(isDark)
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(UIConstants.textFieldBorderRadius),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? UIConstants.textPrimary(isDark) : Colors.grey,
        ),
      ),
    );
  }
}
