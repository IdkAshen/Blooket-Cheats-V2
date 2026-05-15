// Use strict mode for maximum type safety
<<__Strict>>

namespace MyScript;

// Entry point function
<<__EntryPoint>>
function main(): void {
  // Static type declaration
  $item = "Widget";
  $price = 100.50;
  $quantity = 3;
  $tax_rate = 0.05; // 5%

  // Type-checked calculation
  $subtotal = $price * $quantity;
  $total = $subtotal * (1 + $tax_rate);

  // String interpolation and output
  echo "Item: $item\n";
  echo "Subtotal: $$subtotal\n";
  echo "Total (with tax): $$total\n";
}
