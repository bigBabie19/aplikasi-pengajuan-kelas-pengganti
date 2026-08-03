class UiMessage {
  final String message;
  final bool isError;

  const UiMessage({
    required this.message,
    required this.isError,
  });

  const UiMessage.error(String message)
      : message = message,
        isError = true;

  const UiMessage.success(String message)
      : message = message,
        isError = false;
}
