import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Exemplo de teste pendente', (WidgetTester tester) async {
    // Use a anotação @Skip para marcar um teste como pendente
    // e fornecer um motivo opcional.
    // O teste não será executado, mas será relatado como pendente.
    // Este teste será ignorado temporariamente.
    // Você pode fornecer um motivo opcional para indicar por que o teste está pendente.
    // Por exemplo: @Skip("Teste pendente até a implementação do recurso")
    expect(find.text('Hello'), findsOneWidget);
  }, skip: true);
}
