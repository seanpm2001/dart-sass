// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:source_span/source_span.dart';

import '../../visitor/sass/statement.dart';
import '../parent.dart';
import 'expression/interpolation.dart';
import 'statement.dart';

class AtRule implements Statement, Parent<Statement, AtRule> {
  final String name;

  final InterpolationExpression value;

  final List<Statement> children;

  final FileSpan span;

  // TODO: validate that children only contains variable, at-rule, declaration,
  // or style nodes?
  AtRule(this.name, {this.value, Iterable<Statement> children, this.span})
      : children = children == null ? null : new List.unmodifiable(children);

  /*=T*/ accept/*<T>*/(StatementVisitor/*<T>*/ visitor) =>
      visitor.visitAtRule(this);

  AtRule withChildren(Iterable<Statement> children) =>
      new AtRule(name, value: value, children: children, span: span);

  String toString() {
    var buffer = new StringBuffer("@$name");
    if (value != null) buffer.write(" $value");
    return children == null ? "$buffer;" : "$buffer {${children.join(" ")}}";
  }
}