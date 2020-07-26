
import 'dart:math';

import 'package:calculator/utils/constants.dart';
import 'package:petitparser/petitparser.dart';

bool isCharSymbol(ch){
  bool ret = false;
  if(!numbers.contains(ch))
    ret = true;
  print(ret);
  return ret;
}

Parser buildParser() {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive((pattern('+-').optional() &
            digit().plus() &
            (char('.') & digit().plus()).optional() &
            (pattern('eE') & pattern('+-').optional() & digit().plus())
                .optional())
        .flatten('number expected')
        .trim()
        .map(num.tryParse))
    ..wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  builder.group()..prefix(char('-').trim(), (op, a) => -a);
  builder.group()..right(char('^').trim(), (a, op, b) => pow(a, b));
  builder.group()..right(char('%').trim(), (a, op, b) => (a * b)/100);
  builder.group()..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);
  return builder.build().end();
}

double calcString(String text) {
  final parser = buildParser();
  final input = text.replaceAll("x","*").replaceAll("÷", "/").replaceAll(" ", "");
  final result = parser.parse(input);
  if (result.isSuccess)
    return result.value.toDouble();
  else
    return double.parse(text);
}