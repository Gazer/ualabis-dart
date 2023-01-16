enum ErrorType {
  unknown(666),
  apiError(999),
  inputValidation(1000),
  requiredFieldEmpty(1001),
  invalidCredentials(1002),
  invalidAmount(1003),
  userNoExist(1004),
  noOwnerOrder(1005),
  noRecordFound(1006),
  anotherApiError(2004),
  anotherNoOwnerOrder(2005),
  anotherRequiredFieldEmpty(3001),
  anotherUserNoExist(3003),
  invalidClientId(3005),
  invalidClientSecret(3006);

  final int code;

  const ErrorType(this.code);
}