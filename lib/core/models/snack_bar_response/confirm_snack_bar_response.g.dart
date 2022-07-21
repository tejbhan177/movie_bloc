// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_snack_bar_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmSnackBarResponse extends ConfirmSnackBarResponse {
  @override
  final bool confirmed;

  factory _$ConfirmSnackBarResponse(
          [void Function(ConfirmSnackBarResponseBuilder)? updates]) =>
      (new ConfirmSnackBarResponseBuilder()..update(updates))._build();

  _$ConfirmSnackBarResponse._({required this.confirmed}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        confirmed, r'ConfirmSnackBarResponse', 'confirmed');
  }

  @override
  ConfirmSnackBarResponse rebuild(
          void Function(ConfirmSnackBarResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfirmSnackBarResponseBuilder toBuilder() =>
      new ConfirmSnackBarResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmSnackBarResponse && confirmed == other.confirmed;
  }

  @override
  int get hashCode {
    return $jf($jc(0, confirmed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfirmSnackBarResponse')
          ..add('confirmed', confirmed))
        .toString();
  }
}

class ConfirmSnackBarResponseBuilder
    implements
        Builder<ConfirmSnackBarResponse, ConfirmSnackBarResponseBuilder> {
  _$ConfirmSnackBarResponse? _$v;

  bool? _confirmed;
  bool? get confirmed => _$this._confirmed;
  set confirmed(bool? confirmed) => _$this._confirmed = confirmed;

  ConfirmSnackBarResponseBuilder();

  ConfirmSnackBarResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _confirmed = $v.confirmed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmSnackBarResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfirmSnackBarResponse;
  }

  @override
  void update(void Function(ConfirmSnackBarResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmSnackBarResponse build() => _build();

  _$ConfirmSnackBarResponse _build() {
    final _$result = _$v ??
        new _$ConfirmSnackBarResponse._(
            confirmed: BuiltValueNullFieldError.checkNotNull(
                confirmed, r'ConfirmSnackBarResponse', 'confirmed'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
