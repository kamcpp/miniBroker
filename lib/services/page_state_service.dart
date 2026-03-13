/// Simple singleton to persist page state (combo box selections, text fields, etc.)
/// across navigation. State is kept in memory for the session lifetime.
class PageStateService {
  PageStateService._();
  static final PageStateService instance = PageStateService._();

  final Map<String, Map<String, dynamic>> _states = {};

  /// Save state for a page
  void save(String pageId, Map<String, dynamic> state) {
    _states[pageId] = Map<String, dynamic>.from(state);
  }

  /// Get saved state for a page, or null if none
  Map<String, dynamic>? get(String pageId) {
    final s = _states[pageId];
    return s != null ? Map<String, dynamic>.from(s) : null;
  }

  /// Clear state for a page
  void clear(String pageId) {
    _states.remove(pageId);
  }
}
