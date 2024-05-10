
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_app/main.dart';

void main() {
  testWidgets("It shouldn't be able to go to the next page using a lower number than zero or zero", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage(title: 'Test')));

    // Encontrar o widget TextFormField pelo Key
    final textFieldFinder = find.byKey(const Key('text_form_field'));
    expect(textFieldFinder, findsOneWidget);

    // Digitar um valor inválido no campo de texto
    await tester.enterText(textFieldFinder, '0');

    // Disparar o evento de pressionar o botão
    final buttonFinder = find.text('Generate Team');
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);

    // Aguardar a renderização da tela após a pressão do botão
    await tester.pump();

    // Verificar se a mensagem de erro é exibida corretamente
    expect(find.text('The number must be greater than zero.'), findsOneWidget);

    // Digitar um valor inválido no campo de texto
    await tester.enterText(textFieldFinder, '-40');

    // Disparar o evento de pressionar o botão
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);

    // Aguardar a renderização da tela após a pressão do botão
    await tester.pump();

    // Verificar se a mensagem de erro é exibida corretamente
    expect(find.text('The number must be greater than zero.'), findsOneWidget);
  });

  testWidgets("It shouldn't be able to go to the next page using a gratest number than 1302", (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: MyHomePage(title: 'Test2')));

    // Encontrar o widget TextFormField pelo Key
    final textFieldFinder = find.byKey(const Key('text_form_field'));
    expect(textFieldFinder, findsOneWidget);

    // Digitar um valor inválido no campo de texto
    await tester.enterText(textFieldFinder, '1400');

    // Disparar o evento de pressionar o botão
    final buttonFinder = find.text('Generate Team');
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);

    // Aguardar a renderização da tela após a pressão do botão
    await tester.pump();

    // Verificar se a mensagem de erro é exibida corretamente
    expect(find.text('The number must be less than 1303.'), findsOneWidget);
  });

  testWidgets("It shouldn't show any error message when using a number between 0 and 1302", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage(title: 'Test')));

    // Encontre o widget TextFormField pelo Key
    final textFieldFinder = find.byKey(const Key('text_form_field'));
    expect(textFieldFinder, findsOneWidget);

    // Insira um valor válido entre 0 e 1302
    await tester.enterText(textFieldFinder, '500');

    // Dispare o evento de pressionar o botão
    await tester.tap(find.text('Generate Team'));

    // Verificar se o widget de mensagem de erro não está presente na árvore de widgets
    expect(find.text('The number must be greater than zero.'), findsNothing);

    // Verificar se o widget de mensagem de erro não está presente na árvore de widgets
    expect(find.text('The number must be lower than 1303.'), findsNothing);
  });
}
