// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_snack_bar_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmSnackBarRequest extends ConfirmSnackBarRequest {
  @override
  final String message;
  @override
  final String buttonText;
  @override
  final void Function()? onPressed;

  factory _$ConfirmSnackBarRequest(
          [void Function(ConfirmSnackBarRequestBuilder)? updates]) =>
      (new ConfirmSnackBarRequestBuilder()..update(updates))._build();

  _$ConfirmSnackBarRequest._(
      {required this.message, required this.buttonText, this.onPressed})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, r'ConfirmSnackBarRequest', 'message');
    BuiltValueNullFieldError.checkNotNull(
        buttonText, r'ConfirmSnackBarRequest', 'buttonText');
  }

  @override
  ConfirmSnackBarRequest rebuild(
          void Function(ConfirmSnackBarRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfirmSnackBarRequestBuilder toBuilder() =>
      new ConfirmSnackBarRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is ConfirmSnackBarRequest &&
        message == other.message &&
        buttonText == other.buttonText &&
        onPressed == _$dynamicOther.onPressed;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, message.hashCode), buttonText.hashCode),
        onPressed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfirmSnackBarRequest')
          ..add('message', message)
          ..add('buttonText', buttonText)
          ..add('onPressed', onPressed))
        .toString();
  }
}

class ConfirmSnackBarRequestBuilder
    implements Builder<ConfirmSnackBarRequest, ConfirmSnackBarRequestBuilder> {
  _$ConfirmSnackBarRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _buttonText;
  String? get buttonText => _$this._buttonText;
  set buttonText(String? buttonText) => _$this._buttonText = buttonText;

  void Function()? _onPressed;
  void Function()? get onPressed => _$this._onPressed;
  set onPressed(void Function()? onPressed) => _$this._onPressed = onPressed;

  ConfirmSnackBarRequestBuilder();

  ConfirmSnackBarRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _buttonText = $v.buttonText;
      _onPressed = $v.onPressed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmSnackBarRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfirmSnackBarRequest;
  }

  @override
  void update(void Function(ConfirmSnackBarRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmSnackBarRequest build() => _build();

  _$ConfirmSnackBarRequest _build() {
    final _$result = _$v ??
        new _$ConfirmSnackBarRequest._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'ConfirmSnackBarRequest', 'message'),
            buttonText: BuiltValueNullFieldError.checkNotNull(
                buttonText, r'ConfirmSnackBarRequest', 'buttonText'),
            onPressed: onPressed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
