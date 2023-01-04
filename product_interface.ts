export interface Product {
  id: Integer;
  name: String;
  price?: Decimal;
  stock?: Integer;
  created_at: Datetime;
  updated_at: Datetime;
}
